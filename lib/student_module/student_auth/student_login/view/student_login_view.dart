import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pureheartapp/core/utils/app_theme.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/widgets/button_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../teacher_module/students_preview/view/student_preview.dart';
import '../../../../widgets/image/image_widget.dart';
import '../controller/student_login_controller.dart';

class StudentLoginView extends StatelessWidget {
  const StudentLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentLoginController controller = Get.put(StudentLoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    ImageWidget(
                      image: AppImages.logo,
                      fit: BoxFit.cover,
                      width: 80.w,
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Text(
                  "تسجيل دخول الطالب",
                  style: TextStyles.primary712.copyWith(fontSize: 24),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "ألأسم",
                      style: TextStyles.white614,
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
                SizedBox(height: 5),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الاسم مطلوب";
                            } else {
                              return null;
                            }
                          },
                          controller: controller.studentNameController,
                          decoration:
                              InputDecoration(fillColor: AppTheme.primaryColor),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "رقم الهاتف",
                              style: TextStyles.white614,
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'رقم الهاتف مطلوب';
                            } else {
                              return null;
                            }
                          },
                          controller: controller.studentNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            fillColor: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => Text(
                          controller.selectedGrade.value.isNotEmpty
                              ? "الصف: ${controller.selectedGrade.value}"
                              : "اختر المرحلة الدراسية",
                          style: TextStyles.white614,
                        )),
                    SizedBox(width: 5.w),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StageBox(
                      name: "اعدادى",
                      onTap: () => controller.showGradeDialog(
                          context, "اعدادى", ["الرابع", "الخامس", "السادس"]),
                    ),
                    StageBox(
                      name: "متوسط",
                      onTap: () => controller.showGradeDialog(
                          context, "متوسط", ["الأول", "الثاني", "الثالث"]),
                    ),
                    StageBox(
                      name: "ابتدائى",
                      onTap: () => controller.showGradeDialog(
                          context, "ابتدائى", [
                        "الأول",
                        "الثاني",
                        "الثالث",
                        "الرابع",
                        "الخامس",
                        "السادس"
                      ]),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DashedDivider(text: "أو"),
                SizedBox(height: 20),
                Obx(() {
                  return ButtonWidget(
                    isLoading: controller.isLoading.value,
                    onPressFunction: () async {
                      controller.formKey.currentState!.validate();
                      String selectedGradeValue =
                          controller.selectedGrade.value;

                      List<String> parts =
                          selectedGradeValue.split(RegExp(r'\s*-\s*'));

                      if (parts.length == 2) {
                        String stage = parts[0].trim();
                        String grade = parts[1].trim();

                        if (stage.isNotEmpty && grade.isNotEmpty) {
                          int gradeId = controller.getGradeId(grade, stage);

                          if (gradeId != 0) {
                            controller.isLoading.value = true;

                            await controller.requestCreateAccount(gradeId);

                            controller.isLoading.value = false;
                          } else {
                            Get.snackbar(
                              "خطأ",
                              "الصف غير موجود",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      }
                    },
                    width: 180.w,
                    stringText: "تسجيل الدخول",
                  );
                }),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    await controller.pickImage();
                  },
                  child: Column(
                    children: [
                      QrImageView(
                          data: "login",
                          size: 100,
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: Colors.white,
                          ),
                          foregroundColor: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        "أضغط للتسجيل",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StageBox extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const StageBox({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppTheme.white1,
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyles.primary616,
          ),
        ),
      ),
    );
  }
}

class DashedDivider extends StatelessWidget {
  final String text;
  const DashedDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 10,
            indent: 10,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            endIndent: 10,
            indent: 10,
          ),
        ),
      ],
    );
  }
}
