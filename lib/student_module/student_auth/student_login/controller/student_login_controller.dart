import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:zxing2/qrcode.dart';

import 'package:pureheartapp/core/services/shared_pref/shared_pref.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../../../core/utils/variables.dart';

class StudentLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController studentNumberController = TextEditingController();
  var selectedGrade = "".obs;
  RxBool isLoading = false.obs;
  NetworkAPICall apiCall = NetworkAPICall();
  var qrCodeData = ''.obs;

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
              .setString("student_name", data['data']['student_name']);

          SharedPref.sharedPreferences
              .setString("student_id", data['data']['student_id'].toString());

          SharedPref.sharedPreferences
              .setString("student_number", data['data']['student_number']);
          SharedPref.sharedPreferences
              .setInt("student_stage", data['data']['student_stage']);
          SharedPref.sharedPreferences
              .setString("user_type", data['user_type']);

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

  int getGradeId(String grade, String stage) {
    if (stage == "ابتدائى") {
      switch (grade) {
        case "الأول":
          return 1;
        case "الثاني":
          return 2;
        case "الثالث":
          return 3;
        case "الرابع":
          return 4;
        case "الخامس":
          return 5;
        case "السادس":
          return 6;
        default:
          return 0;
      }
    } else if (stage == "متوسط") {
      switch (grade) {
        case "الأول":
          return 7;
        case "الثاني":
          return 8;
        case "الثالث":
          return 9;
        default:
          return 0;
      }
    } else if (stage == "اعدادى") {
      switch (grade) {
        case "الرابع":
          return 10;
        case "الخامس":
          return 11;
        case "السادس":
          return 12;
        default:
          return 0;
      }
    }
    return 0;
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

  Future<void> requestCreateAccount(int studentStage) async {
    try {
      setLoading(true);
      var body = {
        "student_number": studentNumberController.text,
        "student_name": studentNameController.text,
        "student_stage": studentStage,
      };
      var res = await apiCall.postDataAsGuest(
          body, Variables.STUDENT_REQUEST_ACCOUNT);
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

  void showGradeDialog(
      BuildContext context, String stage, List<String> grades) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: grades
                .map(
                  (grade) => ListTile(
                    title: Text(
                      grade,
                      style: TextStyles.primary616,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      selectedGrade.value = "$stage - $grade";
                      Get.back();
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
