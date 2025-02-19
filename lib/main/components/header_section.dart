import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/text_styles.dart';
import '../../core/utils/gaps.dart';
import '../../widgets/image/svg_image_widget.dart';
import '../../widgets/image/image_widget.dart';
import '../../core/services/shared_pref/shared_pref.dart';
import '../view/main_view.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWalletSection(),
          _buildCartSection(),
          _buildRatingSection(),
          _buildUserProfile(),
        ],
      ),
    );
  }

  Widget _buildWalletSection() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.addMoney),
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
              Text(
                " 1000",
                style: TextStyles.white614
                    .copyWith(fontSize: 16.sp, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartSection() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.reqeuestStateView),
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
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
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

  Widget _buildUserProfile() {
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
                  "المعرف:  ${isStudent() ? SharedPref.sharedPreferences.getString("student_id")! : SharedPref.sharedPreferences.getString("teacher_id")!}",
                ),
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
}

bool isStudent() {
  return SharedPref.sharedPreferences.getString("user_type") == "student";
}
