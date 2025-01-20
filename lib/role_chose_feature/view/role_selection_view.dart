import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pureheartapp/core/utils/app_icons.dart';
import 'package:pureheartapp/core/utils/app_theme.dart';
import 'package:pureheartapp/core/utils/gaps.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';

import '../../core/utils/app_images.dart';
import '../../core/utils/text_styles.dart';
import '../../widgets/image/image_widget.dart';
import 'package:get/get.dart';

import '../controller/role_controller.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleSelectionController controller =
        Get.put(RoleSelectionController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
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
              Spacer(),
              Text(
                "تسجيل الدخول",
                style: TextStyles.primary712.copyWith(fontSize: 24),
              ),
              verticalGap(40),
              Obx(() => ChoiseCard(
                    title: "الطالب",
                    iconPath: AppIcons.student,
                    isSelected: controller.selectedRole.value == "student",
                    onTap: () => controller.selectRole("student"),
                  )),
              verticalGap(20),
              Obx(() => ChoiseCard(
                    title: "المعلم",
                    iconPath: AppIcons.teacher,
                    isSelected: controller.selectedRole.value == "teacher",
                    onTap: () => controller.selectRole("teacher"),
                  )),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChoiseCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiseCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0.w),
        decoration: isSelected
            ? BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(4)))
            : BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: AppTheme.white1),
        width: double.maxFinite.w,
        height: 60.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyles.primary712.copyWith(
                    fontSize: 20.sp,
                    color:
                        isSelected ? AppTheme.white1 : AppTheme.primaryColor),
              ),
              horizontalGap(10.w),
              SvgImageWidget(
                image: iconPath,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
