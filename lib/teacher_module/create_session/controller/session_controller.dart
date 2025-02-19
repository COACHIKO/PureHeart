import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pureheartapp/core/utils/variables.dart';
import 'package:pureheartapp/main/components/header_section.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/text_styles.dart';
import '../../../main/controller/main_controller.dart';
import '../../../widgets/button_widget.dart';
import '../../teacher_auth/teacher_login/model/subject_response.dart';

class SessionController extends GetxController {
  TimeOfDay? pickedTime;

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
      var res = await apiCall.getData(
        Variables.GET_TEACHERS_SUBJECTS,
      );
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

  Future<void> createSession({TimeOfDay? time}) async {
    try {
      // Validation checks
      if (time == null) {
        Get.snackbar('خطأ', 'الرجاء اختيار الوقت');
        return;
      }

      if (selectedSubject.value == null) {
        Get.snackbar('خطأ', 'الرجاء اختيار المادة');
        return;
      }

      if (price.text.isEmpty) {
        Get.snackbar('خطأ', 'الرجاء إدخال السعر');
        return;
      }

      final mainController = Get.find<MainController>();
      // Format time in 24-hour format (HH:mm)
      String formattedTime =
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

      // Debug prints
      print("Sending data to API:");
      print("Time: $formattedTime");
      print("Price: ${price.text}");
      print("Subject ID: ${selectedSubject.value?.id}");
      print("Unit Number: ${lessonTitleController.text}");
      print(
          "Teacher Token: ${SharedPref.sharedPreferences.getString("token")}");

      final apiData = isStudent()
          ? {
              "student_token": SharedPref.sharedPreferences.getString("token"),
              "student_price": price.text,
              "subject_id": selectedSubject.value!.id,
              "unit_num": 5,
              "time": formattedTime,
              "student_stage": 3
            }
          : {
              "teacher_token": SharedPref.sharedPreferences.getString("token"),
              "teacher_price": price.text,
              "subject_id": selectedSubject.value!.id,
              "unit_num": 5,
              "time": formattedTime,
            };

      print("API Request Data: $apiData");

      var res = await apiCall.postData(
          isStudent() ? Variables.STUDENT_ADD_AD : Variables.GET_TEACHERS,
          apiData);

      print("API Response: ${res.body}");

      if (res.statusCode == 200) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.snackbar('خطأ', 'حدث خطأ أثناء إنشاء الجلسة');
      }
    } catch (e, stackTrace) {
      debugPrint("Error creating session: $e");
      debugPrint("Stack trace: $stackTrace");
      Get.snackbar('خطأ', 'حدث خطأ غير متوقع');
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

//  final parsedDateTime = inputFormat.parse(inputDateTime);
//       final formattedTime = outputFormat.format(parsedDateTime);

//       final data = {
//         "teacher_token": SharedPref.sharedPreferences.getString("token"),
//         "teacher_price": price.text,
//         "subject_id": selectedSubject.value!.id,
//         "unit_num": lessonTitleController.text,
//         "time": formattedTime,
//       };
  /// Submit session form

  Future<void> publishAd() async {
    try {
      final inputDateTime = "${dateController.text} ${timeController.text}";

      final inputFormat = DateFormat("yyyy-MM-dd h:mm a");
      final outputFormat = DateFormat("HH:mm");
      final parsedDateTime = inputFormat.parse(inputDateTime);
      final formattedTime = outputFormat.format(parsedDateTime);
      var res = await apiCall.postData(Variables.REQUEST_TRANSACTION, {
        "teacher_token": SharedPref.sharedPreferences.getString("token"),
        "teacher_price": price.text,
        "subject_id": selectedSubject.value!.id,
        "unit_num": lessonTitleController.text,
        "time": formattedTime,
      });

      var parsedJson = json.decode(res.body);
      if (parsedJson['status'] == "success") {
      } else {
        Get.snackbar(
          "خطأ",
          "أنت لا تملك النقاط الكافية",
        );
      }

      update();
    } catch (e) {
      print("Error fetching ads: $e");
    }
  }

  void submitSession() async {
    await publishAd();
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
