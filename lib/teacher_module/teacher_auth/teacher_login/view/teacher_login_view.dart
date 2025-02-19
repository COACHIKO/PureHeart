import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pureheartapp/core/utils/app_theme.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/widgets/button_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../widgets/image/image_widget.dart';
import '../controller/teacher_login_controller.dart';

class TeacherLoginView extends StatelessWidget {
  const TeacherLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherLoginController controller = Get.put(TeacherLoginController());

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
                  "تسجيل دخول المعلم",
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
                          controller: controller.teacherNameController,
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
                          controller: controller.teacherNumberController,
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
                    Text("المواد الدراسية", style: TextStyles.white614),
                    SizedBox(width: 5.w),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () => controller.showSubjectDialog(
                      context, controller.subjects),
                  child: Obx(
                    () => TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: controller.selectedSubjects.isEmpty
                            ? "اختر المواد"
                            : controller.selectedSubjects
                                .map((subject) => subject.name)
                                .join(', '),
                        fillColor: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                ImageWidget(
                                  image: AppImages.man,
                                  width: 50.w,
                                  height: 50.h,
                                  fit: BoxFit.cover,
                                ),
                                RadioButton(
                                  title: "ذكر",
                                  value: "1",
                                  groupValue: controller.genderId.value,
                                  onChanged: (value) {
                                    controller.updateRadioSelection(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ImageWidget(
                                  image: AppImages.women,
                                  width: 50.w,
                                  height: 50.h,
                                  fit: BoxFit.cover,
                                ),
                                RadioButton(
                                  title: "أنثئ",
                                  value: "0",
                                  groupValue: controller.genderId.value,
                                  onChanged: (value) {
                                    controller.updateRadioSelection(value!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                DashedDivider(text: "-"),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    InkWell(
                        onTap: () async {
                          await controller.pickImage();
                        },
                        child: Column(
                          children: [
                            QrImageView(
                                data: "login",
                                size: 70,
                                eyeStyle: QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: Colors.white,
                                ),
                                foregroundColor: Colors.white),
                          ],
                        )),
                    Obx(() {
                      return ButtonWidget(
                        isLoading: controller.isLoading.value,
                        onPressFunction: () async {
                          if (controller.formKey.currentState!.validate()) {
                            await controller.requestCreateAccount();
                          }
                        },
                        width: 180.w,
                        stringText: "تسجيل الدخول",
                      );
                    }),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged onChanged;

  const RadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyles.white614,
          ),
          Radio(
            fillColor: WidgetStateProperty.all(Colors.green),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ],
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
