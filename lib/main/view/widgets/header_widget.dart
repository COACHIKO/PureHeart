import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_images.dart';
import 'package:pureheartapp/core/utils/app_icons.dart';
import 'package:pureheartapp/core/utils/text_styles.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';
import 'package:pureheartapp/widgets/image/image_widget.dart';
import '../../../core/services/shared_pref/shared_pref.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/gaps.dart';
import '../../../main/controller/main_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWalletSection(),
              _buildCartSection(),
              _buildRatingSection(),
              _buildUserProfileSection(),
            ],
          ),
          GestureDetector(
            onTap: () async {
              final pickedTime = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay(hour: controller.selectedHour.value, minute: 0),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      alwaysUse24HourFormat: true,
                    ),
                    child: TimePickerDialog(
                      initialTime: TimeOfDay(
                          hour: controller.selectedHour.value, minute: 0),
                      initialEntryMode: TimePickerEntryMode.input,
                      minuteLabelText: '',
                      helpText: 'SELECT HOUR',
                    ),
                  );
                },
              );
              if (pickedTime != null) {
                controller.updateSelectedHour(pickedTime.hour);
                controller.getStudents(controller
                    .subjects[controller.selectedItemIndex.value].id
                    .toString());
              }
            },
            child: ImageWidget(
              image: AppImages.time,
              width: 60.w,
              height: 60.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletSection() {
    final MainController controller = Get.find<MainController>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.addMoney);
      },
      child: Column(
        children: [
          SvgImageWidget(
            image: AppIcons.wallet,
            width: 50,
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ImageWidget(
                  image: AppImages.dollar,
                  width: 20,
                  height: 20,
                ),
              ),
              Obx(() => Text(
                    " ${controller.totalBalance.value / controller.sessions.length}",
                    style: TextStyles.white614
                        .copyWith(fontSize: 16.sp, color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSection() {
    final MainController controller = Get.find<MainController>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.reqeuestStateView);
      },
      child: Stack(
        children: [
          ImageWidget(
            image: AppImages.cart,
            width: 80,
            height: 80,
          ),
          Positioned(
            top: 3,
            left: 15,
            child: Obx(() => Text(
                  '${controller.sessions.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      children: [
        Text(
          "22",
          style: TextStyles.white614
              .copyWith(fontSize: 22.sp, color: Colors.white),
        ),
        Text(
          "التقييم",
          style: TextStyles.white614
              .copyWith(fontSize: 15.sp, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildUserProfileSection() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              isStudent()
                  ? SharedPref.sharedPreferences.getString("student_name")!
                  : SharedPref.sharedPreferences.getString("teacher_name")!,
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
            ),
          ],
        ),
        horizontalGap(5),
        CircleAvatar(
          radius: Get.width * .05,
          child: ImageWidget(
            image: AppImages.boy,
          ),
        ),
      ],
    );
  }

  bool isStudent() {
    return SharedPref.sharedPreferences.getString("user_type") == "student";
  }
}
