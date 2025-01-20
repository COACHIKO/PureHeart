import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/services/shared_pref/shared_pref.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_theme.dart';
import '../../core/utils/gaps.dart';
import '../../core/utils/text_styles.dart';
import '../../main/view/main_view.dart';
import '../../widgets/image/image_widget.dart';
import 'controller/session_controller.dart';

class CreateSession extends StatelessWidget {
  const CreateSession({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SessionController());

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align to the right
                  children: [
                    CircleAvatar(
                      radius: context.width * .05,
                      child: ImageWidget(
                        image: AppImages.boy,
                      ),
                    ),
                    horizontalGap(5),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.end, // Align text to the right
                      children: [
                        Text(
                          isStudent()
                              ? SharedPref.sharedPreferences
                                  .getString("student_name")!
                              : SharedPref.sharedPreferences
                                  .getString("teacher_name")!,
                          style: TextStyles.white614,
                        ),
                        Container(
                          color: const Color(0xFF0030FF),
                          height: 15.h,
                          width: 80.w,
                          child: Center(
                            child: Text(
                                "المعرف:  ${isStudent() ? SharedPref.sharedPreferences.getString("student_id")!.toString() : SharedPref.sharedPreferences.getString("teacher_id")!.toString()}"),
                          ),
                        )
                      ],
                    ),
                    horizontalGap(5),
                    Text(
                      "👋",
                      style: TextStyle(fontSize: 22.sp),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text("أسم المادة", style: TextStyles.white720),
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
                        fillColor: AppTheme.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("السعر", style: TextStyles.white720),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  controller: controller.price,
                  decoration: const InputDecoration(hintText: "سعر الحصة"),
                  validator: (value) =>
                      value!.isEmpty ? "برجاء إدخال سعر الحصة" : null,
                ),
                const SizedBox(height: 20),
                Text("الفصل", style: TextStyles.white720),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.number,
                  controller: controller.lessonTitleController,
                  decoration: const InputDecoration(hintText: "رقم الفصل"),
                  validator: (value) =>
                      value!.isEmpty ? "برجاء إدخال رقم الفصل" : null,
                ),
                const SizedBox(height: 20),
                Text("التاريخ", style: TextStyles.white720),
                GestureDetector(
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      controller.dateController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    }
                  },
                  child: TextFormField(
                    controller: controller.dateController,
                    enabled: false,
                    textAlign: TextAlign.right, // Align text to the right
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(hintText: "التاريخ"),
                  ),
                ),
                const SizedBox(height: 20),
                Text("الساعة", style: TextStyles.white720),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      controller.timeController.text =
                          selectedTime.format(context);
                    }
                  },
                  child: TextFormField(
                    controller: controller.timeController,
                    enabled: false,
                    textAlign: TextAlign.right, // Align text to the right
                    decoration: const InputDecoration(hintText: "الساعة"),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                Text("الوصف", style: TextStyles.white720),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.right, // Align text to the right
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(hintText: "الوصف"),
                  maxLines: 4,
                  validator: (value) =>
                      value!.isEmpty ? "برجاء إدخال الوصف" : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.submitSession();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  child: const Text(
                    "إضافة الدرس",
                    style: TextStyle(color: Colors.black),
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
