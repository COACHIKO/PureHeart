import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_icons.dart';
import 'package:pureheartapp/core/utils/app_images.dart';
import 'package:pureheartapp/core/utils/text_styles.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';

import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_theme.dart';
import '../../../core/utils/gaps.dart';
import '../../../main/components/header_section.dart';
import '../../../main/view/main_view.dart';
import '../../../widgets/appbar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/custom_navigation_bar.dart';
import '../../../widgets/image/image_widget.dart';
import '../controller/student_preview_controller.dart';

class TeacherPreviewView extends StatelessWidget {
  const TeacherPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TeachersPreviewController>();

    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                verticalGap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "👋",
                            style: TextStyle(fontSize: 22.sp),
                          ),
                          horizontalGap(5),
                          Column(
                            children: [
                              horizontalGap(5),
                              Text(
                                isStudent()
                                    ? SharedPref.sharedPreferences
                                        .getString("student_name")!
                                    : SharedPref.sharedPreferences
                                        .getString("teacher_name")!,
                                style: TextStyles.white614,
                              ),
                              Container(
                                color: Color(0xFF0030FF),
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
                          CircleAvatar(
                            radius: context.width * .05,
                            child: ImageWidget(
                              image: AppImages.boy,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.primaryColor,
                                  radius: context.width * .04,
                                  child: SvgImageWidget(
                                    image: AppIcons.bookmark,
                                  ),
                                ),
                                horizontalGap(10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.primaryColor,
                                  radius: context.width * .04,
                                  child: SvgImageWidget(
                                    image: AppIcons.info,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "اختر طالب",
                              style: TextStyles.white720,
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        style: TextStyles.black714.copyWith(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 16.sp),
                          hintText: "ابحث عن طالب",
                          suffixIcon: Icon(Icons.search, size: 28.sp),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      verticalGap(20),
                      SizedBox(
                        width: context.width,
                        height: context.height * 0.6,
                        child: ListView.builder(
                          itemCount: controller.teacherAds.length,
                          itemBuilder: (context, index) {
                            final student = controller.teacherAds[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 8.h),
                              child: Card(
                                color: AppTheme.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0.w, vertical: 8.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppTheme.primaryColor,
                                                radius: context.width * .04,
                                                child: SvgImageWidget(
                                                  image: AppIcons.bookmark,
                                                ),
                                              ),
                                              horizontalGap(5),
                                              FractionalStarRating(
                                                rating: 1.toDouble(),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(student.teacherName,
                                                  style: TextStyles.black714),
                                              Text(student.timeSincePost,
                                                  style: TextStyles.grey512),
                                            ],
                                          ),
                                          horizontalGap(5),
                                          CircleAvatar(
                                            radius: context.width * .05,
                                            child: ImageWidget(
                                                image: AppImages.boy),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        height: .2.h,
                                        color: AppTheme.grey,
                                      ),
                                      verticalGap(10.h),
                                      Text(
                                        textAlign: TextAlign.right,
                                        student.description,
                                        style: TextStyles.black714,
                                      ),
                                      verticalGap(10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.right,
                                            "توقيت الحصة : ${student.date}",
                                            style: TextStyles.black714,
                                          ),
                                        ],
                                      ),
                                      verticalGap(10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.right,
                                            "تاريخ الحصة : ${student.date.toString().substring(0, 10)}",
                                            style: TextStyles.black714,
                                          ),
                                        ],
                                      ),
                                      verticalGap(10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.right,
                                            "سعر الحصة : ${student.teacherPrice}",
                                            style: TextStyles.black714,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        height: .2.h,
                                        color: AppTheme.grey,
                                      ),
                                      verticalGap(10.h),
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                CustomRadioButton(
                                                  title: "موافق",
                                                  value: "موافق",
                                                  groupValue: controller
                                                              .radioSelections[
                                                          student.adId] ??
                                                      "غير موافق",
                                                  onChanged: (value) {
                                                    controller
                                                        .updateRadioSelection(
                                                            student.adId,
                                                            value!);
                                                  },
                                                ),
                                                CustomRadioButton(
                                                    title: "غير موافق",
                                                    value: "غير موافق",
                                                    groupValue: controller
                                                                .radioSelections[
                                                            student.adId] ??
                                                        "غير موافق",
                                                    onChanged: (value) {
                                                      if (value == "موافق") {}
                                                      controller
                                                          .updateRadioSelection(
                                                              student.adId,
                                                              value!);
                                                    }),
                                              ],
                                            ),
                                            Text(
                                              "خيار تحديد الطالب",
                                              style: TextStyles.black714,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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

class StudentPreviewView extends StatelessWidget {
  const StudentPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentsPreviewController>();

    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                verticalGap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "👋",
                            style: TextStyle(fontSize: 22.sp),
                          ),
                          horizontalGap(5),
                          Column(
                            children: [
                              horizontalGap(5),
                              Text(
                                SharedPref.sharedPreferences
                                    .getString("teacher_name")!,
                                style: TextStyles.white614,
                              ),
                              Container(
                                color: Color(0xFF0030FF),
                                height: 15.h,
                                width: 80.w,
                                child: Center(
                                  child: Text(
                                    "المعرف:  ${SharedPref.sharedPreferences.getString("teacher_id").toString()}",
                                  ),
                                ),
                              )
                            ],
                          ),
                          horizontalGap(5),
                          CircleAvatar(
                            radius: context.width * .05,
                            child: ImageWidget(
                              image: AppImages.boy,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppTheme.primaryColor,
                                  radius: context.width * .04,
                                  child: SvgImageWidget(
                                    image: AppIcons.bookmark,
                                  ),
                                ),
                                horizontalGap(10),
                                CircleAvatar(
                                  backgroundColor: AppTheme.primaryColor,
                                  radius: context.width * .04,
                                  child: SvgImageWidget(
                                    image: AppIcons.info,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "اختر طالب",
                              style: TextStyles.white720,
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        style: TextStyles.black714.copyWith(fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              textBaseline: TextBaseline.alphabetic,
                              fontSize: 16.sp),
                          hintText: "ابحث عن طالب",
                          suffixIcon: Icon(Icons.search, size: 28.sp),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      verticalGap(20),
                      SizedBox(
                        width: context.width,
                        height: context.height * 0.6,
                        child: ListView.builder(
                          itemCount: controller.studentAds.length,
                          itemBuilder: (context, index) {
                            final student = controller.studentAds[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 8.h),
                              child: Card(
                                color: AppTheme.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0.w, vertical: 8.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              horizontalGap(5),
                                              Text(
                                                student.studentRate
                                                    .toDouble()
                                                    .toString(),
                                                style: TextStyles.black714
                                                    .copyWith(
                                                        fontSize: 25.sp,
                                                        color: Colors.green),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(student.studentName,
                                                  style: TextStyles.black714),
                                              Text(student.timeSincePost,
                                                  style: TextStyles.grey512),
                                            ],
                                          ),
                                          horizontalGap(5),
                                          CircleAvatar(
                                            radius: context.width * .05,
                                            child: ImageWidget(
                                                image: AppImages.boy),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        height: .2.h,
                                        color: AppTheme.grey,
                                      ),
                                      verticalGap(10.h),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.right,
                                                "${student.time} :",
                                                style: TextStyles.black714,
                                              ),
                                              ImageWidget(
                                                image: AppImages.time,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                          verticalGap(10.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                textAlign: TextAlign.left,
                                                "دينار",
                                                style: TextStyles.black714,
                                              ),
                                              Text(
                                                textAlign: TextAlign.left,
                                                " 2000  :",
                                                style: TextStyles.black714,
                                              ),
                                              horizontalGap(10),
                                              SvgImageWidget(
                                                image: AppIcons.dinar,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      verticalGap(10.h),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   children: [
                                      //     Text(
                                      //       textAlign: TextAlign.right,
                                      //       "تاريخ الحصة : ${student.sessionDate.toString().substring(0, 10)}",
                                      //       style: TextStyles.black714,
                                      //     ),
                                      //   ],
                                      // ),
                                      verticalGap(10.h),

                                      verticalGap(10.h),
                                      // Obx(
                                      //   () => Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.end,
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           CustomRadioButton(
                                      //             title: "موافق",
                                      //             value: "موافق",
                                      //             groupValue: controller
                                      //                         .radioSelections[
                                      //                     student.id] ??
                                      //                 "غير موافق",
                                      //             onChanged: (value) {
                                      //               if (value == "موافق") {
                                      //                 controller.createSession({
                                      //                   "teacher_token":
                                      //                       SharedPref
                                      //                           .sharedPreferences
                                      //                           .getString(
                                      //                               "token"),
                                      //                   "student_ad":
                                      //                       student.id,
                                      //                 });
                                      //               }
                                      //               controller
                                      //                   .updateRadioSelection(
                                      //                       student.id, value!);
                                      //             },
                                      //           ),
                                      //           CustomRadioButton(
                                      //               title: "غير موافق",
                                      //               value: "غير موافق",
                                      //               groupValue: controller
                                      //                           .radioSelections[
                                      //                       student.id] ??
                                      //                   "غير موافق",
                                      //               onChanged: (value) {
                                      //                 if (value == "موافق") {
                                      //                   controller
                                      //                       .createSession({
                                      //                     "teacher_token":
                                      //                         SharedPref
                                      //                             .sharedPreferences
                                      //                             .getString(
                                      //                                 "token"),
                                      //                     "student_ad":
                                      //                         student.id,
                                      //                   });
                                      //                 }

                                      //                 controller
                                      //                     .updateRadioSelection(
                                      //                         student.id,
                                      //                         value!);
                                      //               }),
                                      //         ],
                                      //       ),
                                      //       // Text(
                                      //       //   "خيار تحديد الطالب",
                                      //       //   style: TextStyles.black714,
                                      //       // ),
                                      //     ],
                                      //   ),
                                      // ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ButtonWidget(
                                            color: const Color.fromARGB(
                                                255, 252, 137, 84),
                                            width: 150,
                                            onPressFunction: () async {},
                                            stringText: "رفض",
                                          ),
                                          ButtonWidget(
                                            color: Colors.green,
                                            width: 150,
                                            onPressFunction: () async {},
                                            stringText: "قبول",
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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

class CustomRadioButton extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged onChanged;

  const CustomRadioButton({
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
            style: TextStyles.black413,
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

class FractionalStarRating extends StatelessWidget {
  final double rating;
  final double size;

  const FractionalStarRating(
      {super.key, required this.rating, this.size = 15.0});

  @override
  Widget build(BuildContext context) {
    bool isFullStar = rating >= 1;
    bool isHalfStar = rating < 1 && rating >= 0.5;
    bool isEmptyStar = rating < 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isFullStar)
          Icon(
            Icons.star,
            color: Colors.amber,
            size: size,
          ),
        if (isHalfStar)
          Icon(
            Icons.star_half, // Half star
            color: Colors.amber,
            size: size,
          ),
        if (isEmptyStar)
          Icon(
            Icons.star_border, // Empty star
            color: Colors.amber,
            size: size,
          ),
        horizontalGap(5),
        Text(rating.toStringAsFixed(1),
            style: TextStyle(fontSize: 13.sp, color: Colors.black)),
      ],
    );
  }
}
