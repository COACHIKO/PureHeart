import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_images.dart';
import 'package:pureheartapp/core/utils/text_styles.dart';
import 'package:pureheartapp/widgets/button_widget.dart';
import 'package:pureheartapp/widgets/image/image_widget.dart';
import '../../../core/utils/gaps.dart';
import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../teacher_module/teacher_auth/teacher_login/model/student_response.dart';
import '../../controller/main_controller.dart';

class AdsWidget extends StatelessWidget {
  final MainController controller;

  const AdsWidget({super.key, required this.controller});

  bool isStudent() {
    return SharedPref.sharedPreferences.getString("user_type") == "student";
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = context.width * 0.7;
    return Obx(() => SizedBox(
          width: cardWidth,
          height: 430,
          child: PageView.builder(
            itemCount: isStudent()
                ? controller.teacherAds.length
                : controller.studentAds.length,
            controller: PageController(viewportFraction: 1),
            itemBuilder: (context, index) {
              return isStudent()
                  ? _buildTeacherAdCard(controller.teacherAds[index], cardWidth)
                  : _buildStudentAdCard(
                      controller.studentAds[index], cardWidth);
            },
          ),
        ));
  }

  Widget _buildStudentAdCard(StudentAd studentAd, double cardWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: cardWidth - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildImageSection(cardWidth, studentAd.studentRate.toString()),
          verticalGap(25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeSection(studentAd.time),
              verticalGap(10),
              Container(
                width: 1,
                height: 70.h,
                color: Colors.black,
              ),
              verticalGap(10),
              _buildPriceSection(studentAd.studentPrice.toString()),
            ],
          ),
          verticalGap(30),
          _buildAcceptButton(studentAd),
        ],
      ),
    );
  }

  Widget _buildTeacherAdCard(TeacherAd teacherAd, double cardWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: cardWidth - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildImageSection(cardWidth, 0.toString()),
          verticalGap(25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeSection(teacherAd.timeSincePost),
              verticalGap(10),
              Container(
                width: 1,
                height: 70.h,
                color: Colors.black,
              ),
              verticalGap(10),
              _buildPriceSection(teacherAd.teacherPrice.toString()),
            ],
          ),
          verticalGap(30),
          _buildAcceptButton(null, teacherAd),
        ],
      ),
    );
  }

  Widget _buildImageSection(double cardWidth, String rating) {
    return Stack(
      children: [
        Container(
          width: cardWidth - 20,
          height: 438 / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: Colors.black,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: ImageWidget(
              fit: BoxFit.cover,
              image: AppImages.doctor,
              width: cardWidth - 20,
              height: 438 / 2,
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            rating,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection(String time) {
    return Column(
      children: [
        ImageWidget(
          image: AppImages.time,
          width: 60,
          height: 60,
        ),
        verticalGap(5),
        Text(
          time,
          style: TextStyles.black714.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildPriceSection(String price) {
    return Column(
      children: [
        ImageWidget(
          image: AppImages.dollar,
          width: 60,
          height: 60,
        ),
        Row(
          children: [
            Text(
              "دينار",
              style: TextStyles.black714.copyWith(fontSize: 12.sp),
            ),
            Text(
              price,
              style: TextStyles.black714.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAcceptButton([StudentAd? studentAd, TeacherAd? teacherAd]) {
    return ButtonWidget(
      height: 40,
      width: 250,
      tColor: Colors.black,
      stringText: "موافق",
      color: Color(0xFFB8E945),
      onPressFunction: () async {
        isStudent()
            ? await controller.requestTransaction(
                teacherAd!.teacherId, teacherAd.teacherPrice, teacherAd.adId)
            : {
                await controller.acceptOffer(studentAd!.id),
              };
      },
    );
  }
}
