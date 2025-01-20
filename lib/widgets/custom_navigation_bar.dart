import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_routes.dart';
import 'package:pureheartapp/core/utils/gaps.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';
import '../core/services/shared_pref/shared_pref.dart';
import '../core/utils/app_icons.dart';
import '../main/view/main_view.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
          height: context.height * 0.095,
          decoration: const BoxDecoration(
              color: Color(0xFF020A61),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNavigationBarItem(
                label:
                    isStudent() ? "المعلمين النشطون".tr : "الطلاب النشطون".tr,
                index: 0,
                icon: AppIcons.activeTeachers,
                onTap: () {
                  SharedPref.sharedPreferences.clear();
                },
              ),
              CustomNavigationBarItem(
                label: isStudent() ? 'المعلم الفورى'.tr : 'الطالب الفورى'.tr,
                index: 1,
                icon: AppIcons.instantTeacher,
                onTap: () {},
              ),
              SizedBox(width: 70),
              CustomNavigationBarItem(
                label: 'تقييم الطالب'.tr,
                index: 2,
                icon: AppIcons.studentChart,
                onTap: () {},
              ),
              CustomNavigationBarItem(
                label: 'المناهج/ الملازم'.tr,
                index: 3,
                icon: AppIcons.content,
                onTap: () {
                  Get.toNamed(AppRoutes.createPaper);
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          left: (MediaQuery.of(context).size.width / 2) - 30,
          child: Column(
            children: [
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  Get.toNamed(AppRoutes.createSession);
                },
                backgroundColor: const Color(0xFFFFA52A),
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              verticalGap(14.h),
              const Text(
                "إنشاء درس",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomNavigationBarItem extends StatelessWidget {
  final String label;
  final int index;
  final String icon;
  final VoidCallback? onTap;

  const CustomNavigationBarItem({
    required this.label,
    required this.index,
    required this.icon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImageWidget(
            image: icon,
            color: Colors.white,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.sp,
            ),
          ),
        ],
      ),
    );
  }
}
