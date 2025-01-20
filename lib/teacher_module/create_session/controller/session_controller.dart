import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/text_styles.dart';
import '../../../widgets/button_widget.dart';
import '../../teacher_auth/teacher_login/model/subject_response.dart';

class SessionController extends GetxController {
  // Form Key for validation
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers for form fields
  TextEditingController lessonTitleController = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  // Observables
  var selectedSubjects = <Subject>[].obs;

  // API and data
  NetworkAPICall apiCall = NetworkAPICall();
  late List<Subject> subjects = [];

  @override
  void onInit() {
    super.onInit();
    getSubjects(); // Fetch subjects on initialization
  }

  /// Fetch subjects from the API
  Future<void> getSubjects() async {
    try {
      var res = await apiCall.postData(
          "http://192.168.1.2/pureHeart/api/get_data/get_teacher_subjects.php",
          {"token": SharedPref.sharedPreferences.getString("token")});
      if (res.statusCode == 200) {
        var parsedJson = json.decode(res.body);
        SubjectsResponse subjectsResponse =
            SubjectsResponse.fromJson(parsedJson);
        subjects = subjectsResponse.subjects;
        print("Subjects: ${subjects.length}");
      }
    } catch (e) {
      debugPrint("Error fetching subjects: $e");
    }
  }

  Future<void> createSession(data) async {
    try {
      var res = await apiCall.postData(
          "http://192.168.1.2/pureHeart/api/ad_center/teacher_ad_add.php",
          data);
      if (res.statusCode == 200) {
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      debugPrint("Error fetching subjects: $e");
    }
  }

  /// Show subject selection dialog
  Rx<Subject?> selectedSubject = Rx<Subject?>(null);

  void showSubjectDialog(BuildContext context, List<Subject> subjects) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "إختر المواد",
                    style: TextStyles.black714.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  ...subjects.map(
                    (subject) => GestureDetector(
                      onTap: () {
                        if (selectedSubject.value == subject) {
                          selectedSubject.value = null;
                        } else {
                          selectedSubject.value = subject;
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedSubject.value == subject
                              ? Colors.red.withOpacity(0.2)
                              : Colors.white,
                          border: Border.all(
                            color: selectedSubject.value == subject
                                ? Colors.red
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            subject.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedSubject.value == subject
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ButtonWidget(
                    onPressFunction: () {
                      if (selectedSubject.value != null) {
                        selectedSubjects.value = [selectedSubject.value!];
                      } else {
                        selectedSubjects.value = [];
                      }
                      Get.back();
                    },
                    stringText: "تأكيد",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Submit session form

  void submitSession() async {
    final inputDateTime = "${dateController.text} ${timeController.text}";

    final inputFormat = DateFormat("yyyy-MM-dd h:mm a");
    final outputFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      final parsedDateTime = inputFormat.parse(inputDateTime);

      final formattedDateTime = outputFormat.format(parsedDateTime);

      final data = {
        "teacher_token": SharedPref.sharedPreferences.getString("token"),
        "teacher_price": price.text,
        "subject_id": selectedSubject.value!.id,
        "unit_num": lessonTitleController.text,
        "description": descriptionController.text,
        "date": formattedDateTime,
      };
      await createSession(data);

      debugPrint("Form Data: $data");
    } catch (e) {
      debugPrint("Error formatting dateTime: $e");
    }
  }

  @override
  void onClose() {
    lessonTitleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
