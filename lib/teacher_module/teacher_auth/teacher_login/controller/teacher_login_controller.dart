import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pureheartapp/widgets/button_widget.dart';
import 'package:zxing2/qrcode.dart';
import 'package:image/image.dart' as img;

import 'package:pureheartapp/core/services/shared_pref/shared_pref.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/utils/variables.dart';
import '../model/subject_response.dart';

class TeacherLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController teacherNameController = TextEditingController();
  TextEditingController teacherNumberController = TextEditingController();
  var selectedGrade = "".obs;
  RxBool isLoading = false.obs;
  NetworkAPICall apiCall = NetworkAPICall();
  var qrCodeData = ''.obs;
  late List<Subject> subjects = [];
  RxMap<int, String> radioSelections = <int, String>{}.obs;

// In your controller:
  RxString genderId = 'رجل'.obs; // Initial value can be "رجل" or "إمرأة"

  void updateRadioSelection(String selection) {
    genderId.value = selection;
    print(genderId.value);
  }

  onInit() async {
    super.onInit();
    await getSubjects();
  }

  Future<void> getSubjects() async {
    try {
      var res = await apiCall.getDataAsGuest(Variables.GET_SUBJECTS);

      if (res.statusCode == 200) {
        var parsedJson = json.decode(res.body);

        SubjectsResponse subjectsResponse =
            SubjectsResponse.fromJson(parsedJson);
        subjects = subjectsResponse.subjects;
      } else {
        print('Failed to fetch subjects. Status code: ${res.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(token) async {
    try {
      var body = {
        "token": token,
      };
      var res = await apiCall.postDataAsGuest(body, Variables.LOGIN);
      print(res.body);
      final Map<String, dynamic> data = jsonDecode(res.body);

      if (200 == res.statusCode) {
        if (data['status'] == "success") {
          SharedPref.sharedPreferences.setString("token", token);
          SharedPref.sharedPreferences
              .setString("teacher_name", data['data']['teacher_name']);
          SharedPref.sharedPreferences
              .setString("teacher_id", data['data']['teacher_number']);
          SharedPref.sharedPreferences
              .setString("teacher_id", data['data']['teacher_id'].toString());

          Get.offAllNamed(AppRoutes.main);
        } else {
          ShowToast.showCustomSnackBar(
              message: data['message'] == "Invalid token or user not found"
                  ? "المستخدم غير موجود"
                  : data['message']);
        }
      } else {
        ShowToast.showSuccessSnackBar(message: data['status']);
      }
    } catch (e) {
      print(e);

      ShowMessage.toast(e.toString());
    } finally {}
  }

  void setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await decode(image.path);
    }
  }

  Future<void> decode(String path) async {
    try {
      final File imageFile = File(path);
      final result = await decodeImage(imageFile);
      if (result != null && result.isNotEmpty) {
        qrCodeData.value = result;
      } else {
        ShowToast.showCustomSnackBar(message: 'Unable to decode QR code.');
      }
    } catch (e) {
      ShowToast.showCustomSnackBar(
          message: 'Error occurred while decoding QR code.');
    }
  }

  Future<String?> decodeImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        return null;
      }
      final List<int> argbPixels = [];
      for (int y = 0; y < image.height; y++) {
        for (int x = 0; x < image.width; x++) {
          final pixel = image.getPixel(x, y);

          final int argb = ((pixel.a as int) << 24) |
              ((pixel.r as int) << 16) |
              ((pixel.g as int) << 8) |
              (pixel.b as int);
          argbPixels.add(argb);
        }
      }
      final Int32List int32Pixels = Int32List.fromList(argbPixels);
      final luminanceSource =
          RGBLuminanceSource(image.width, image.height, int32Pixels);
      final binaryBitmap = BinaryBitmap(HybridBinarizer(luminanceSource));
      final reader = QRCodeReader();
      final result = reader.decode(binaryBitmap);
      await login(result.text);

      return result.text;
    } catch (e) {
      return null;
    }
  }

  Future<void> requestCreateAccount() async {
    try {
      setLoading(true);
      var body = {
        "teacher_number": teacherNumberController.text,
        "teacher_name": teacherNameController.text,
        "teacher_subject":
            selectedSubjects.map((subject) => subject.id).toList(),
        "gender": genderId
      };
      var res = await apiCall.postDataAsGuest(
          body, Variables.TEACHER_REQUEST_ACCOUNT);
      print(res.body);
      final Map<String, dynamic> errorData = jsonDecode(res.body);

      if (200 == res.statusCode) {
      } else {
        ShowToast.showSuccessSnackBar(message: errorData['status']);
      }
    } catch (e) {
      print(e);

      ShowMessage.toast(e.toString());
    } finally {
      setLoading(false);
    }
  }

  RxList<Subject> selectedSubjects = <Subject>[].obs;

  void showSubjectDialog(BuildContext context, List<Subject> subjects) {
    RxList<Subject> selectedSubjectsList = <Subject>[].obs;

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
                        if (selectedSubjectsList.contains(subject)) {
                          selectedSubjectsList.remove(subject);
                        } else {
                          selectedSubjectsList.add(subject);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: selectedSubjectsList.contains(subject)
                              ? Colors.red.withOpacity(0.2)
                              : Colors.white,
                          border: Border.all(
                            color: selectedSubjectsList.contains(subject)
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
                              color: selectedSubjectsList.contains(subject)
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
                      selectedSubjects.value = selectedSubjectsList;

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


}
