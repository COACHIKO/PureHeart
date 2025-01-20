import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/app_images.dart';
import 'package:pureheartapp/core/utils/text_styles.dart';
import 'package:pureheartapp/widgets/image/svg_image_widget.dart';
import '../../core/services/shared_pref/shared_pref.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/app_theme.dart';
import '../../core/utils/gaps.dart';
import '../../teacher_module/students_preview/controller/student_preview_controller.dart';
import '../../teacher_module/teacher_auth/teacher_login/model/student_response.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/custom_navigation_bar.dart';
import '../../widgets/image/image_widget.dart';
import '../controller/main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                verticalGap(20),
                Column(
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
                  ],
                ),
                verticalGap(context.height * .03),
                SizedBox(
                  width: context.width,
                  child: CarouselSlider.builder(
                    itemCount: controller.imagesList.length,
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                      height: context.height * .25,
                      autoPlay: false,
                      onPageChanged: (index, _) {
                        controller.changeImageIndex(index);
                      },
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          _showFullScreenImage(
                            context,
                            controller.imagesList[index],
                          );
                        },
                        child: ImageWidget(
                          image: controller.imagesList[index],
                          fit: BoxFit.cover,
                          width: context.width,
                          height: context.height * .12,
                        ),
                      );
                    },
                  ),
                ),
                verticalGap(context.height * .03),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22.0),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SvgImageWidget(
                            image: AppIcons.wallet,
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            "المحفظة",
                            style: TextStyles.white614
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgImageWidget(
                            image: AppIcons.dinar,
                            width: 50,
                            height: 50,
                          ),
                          Text(
                            "1000دينار",
                            style: TextStyles.white614
                                .copyWith(fontSize: 15, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalGap(context.height * .03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Find the AdsPreviewController instances
                          final controllers =
                              Get.find<StudentsPreviewController>();
                          final teacherAdsController =
                              Get.find<TeachersPreviewController>();

                          if (isStudent()) {
                            // For student: Clear existing ads, add new ones, and navigate to student preview screen
                            teacherAdsController.teacherAds.clear();
                            teacherAdsController.teacherAds
                                .addAll(controller.teacherAds);
                            Get.toNamed(AppRoutes.teacherPreview);
                          } else {
                            // For teacher: Clear existing ads, add new ones, and navigate to teacher preview screen
                            controllers.studentAds.clear();
                            controllers.studentAds
                                .addAll(controller.studentAds);
                            Get.toNamed(AppRoutes.studentPreview);
                          }
                        },
                        style: ButtonStyle(
                          // Set the button's background color to the primary color defined in AppTheme
                          backgroundColor: WidgetStateProperty.all<Color>(
                              AppTheme.primaryColor),

                          // Apply padding to make the button more touch-friendly
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5)),
                        ),
                        child: Text(
                          "عرض الكل", // Arabic text for "View All"
                          style: TextStyles.white614.copyWith(
                              fontSize: 15), // White text with font size 15
                        ),
                      ),
                      Text(
                        isStudent() ? "المعلمون النشطون" : "الطلاب النشطون",
                        style: TextStyles.white614.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                verticalGap(context.height * .03),
                Obx(
                  () => SizedBox(
                    width: context.width * .9,
                    height: 130.h,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: isStudent()
                          ? controller.teacherAds.length
                          : controller.studentAds.length,
                      itemBuilder: (context, index) {
                        final ad = isStudent()
                            ? controller.teacherAds[index]
                            : controller.studentAds[index];
                        return GestureDetector(
                          onTap: () {
                            final adsController =
                                Get.find<StudentsPreviewController>();
                            final teacherAdsController =
                                Get.find<TeachersPreviewController>();

                            adsController.studentAds.clear();
                            teacherAdsController.teacherAds.clear();

                            if (ad is StudentAd) {
                              adsController.studentAds.add(ad);
                            } else if (ad is TeacherAd) {
                              teacherAdsController.teacherAds.add(ad);
                            }

                            Get.toNamed(isStudent()
                                ? AppRoutes.teacherPreview
                                : AppRoutes.studentPreview);
                          },
                          child: SizedBox(
                            child: Card(
                              color: AppTheme.white,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: FractionalStarRating(
                                          rating: isStudent()
                                              ? 1
                                              : (ad as StudentAd)
                                                  .studentRate
                                                  .toDouble(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalGap(5),
                                  CircleAvatar(
                                    maxRadius: 30,
                                    minRadius: 30,
                                    child: ImageWidget(image: AppImages.boy),
                                  ),
                                  verticalGap(10),
                                  Text(
                                    isStudent()
                                        ? "${(ad as TeacherAd).teacherName}\n${(ad).subjectName}"
                                        : "${(ad as StudentAd).studentName}\n${(ad).studentStepName}",
                                    style: TextStyles.black413
                                        .copyWith(fontSize: 13.sp),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                verticalGap(context.height * .027),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: Text(
                        "المواد الدراسية",
                        style: TextStyles.white614.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: context.width * .9,
                  child: FutureBuilder<void>(
                    future: controller.getSubjects(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SizedBox(
                          width: context.width * .9,
                          height: 180.h,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.3,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: controller.subjects.length,
                            itemBuilder: (context, index) {
                              final subject = controller.subjects[index];

                              return GestureDetector(
                                onTap: () {
                                  controller.changeSelectedItemIndex(index);
                                },
                                child: Obx(
                                  () => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: CircleAvatar(
                                            radius: context.width * .1,
                                            backgroundColor: controller
                                                        .selectedItemIndex
                                                        .value ==
                                                    index
                                                ? AppTheme.primaryColor
                                                : Colors.white,
                                            child: ImageWidget(
                                              image: subject.icon,
                                            ),
                                          ),
                                        ),
                                        verticalGap(5),
                                        Text(subject.name,
                                            style: TextStyles.white409.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
                verticalGap(context.height * .05),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

void _showFullScreenImage(BuildContext context, String image) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(context.width, context.height * .098),
          child: AppbarWidget(
            onTap: () {
              AppRoutes.pop();
            },
            backColor: AppTheme.black,
            iconColor: AppTheme.white,
          ),
        ),
        body: Container(
          width: context.width,
          height: context.height,
          color: AppTheme.black,
          child: Center(
            child: Hero(
              tag: 'fullScreenImage'.tr,
              child: ImageWidget(
                image: image,
                width: context.width,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ),
  );
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

class StudentAdsWidget extends StatelessWidget {
  final List<StudentAd> studentAds;

  StudentAdsWidget({required this.studentAds});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .9,
      height: 130.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 5,
          childAspectRatio: 0.9,
        ),
        itemCount: studentAds.length,
        itemBuilder: (context, index) {
          final studentAd = studentAds[index];
          return GestureDetector(
            onTap: () {
              // final controller = Get.find<StudentsPreviewController>();
              // controller.studentAds.clear();
              // controller.studentAds.add(studentAd);
              // Get.toNamed(AppRoutes.studentPreview);
            },
            child: SizedBox(
              child: Card(
                color: AppTheme.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FractionalStarRating(
                            rating: studentAd.studentRate.toDouble(),
                          ),
                        ),
                      ],
                    ),
                    verticalGap(5),
                    CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      child: ImageWidget(image: AppImages.boy),
                    ),
                    verticalGap(10),
                    Text(
                      "${studentAd.studentName}\n${studentAd.studentStepName}",
                      style: TextStyles.black413.copyWith(fontSize: 13.sp),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TeacherAdsWidget extends StatelessWidget {
  final List<TeacherAd> teacherAds;

  const TeacherAdsWidget({super.key, required this.teacherAds});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .9,
      height: 130.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 5,
          childAspectRatio: 0.9,
        ),
        itemCount: teacherAds.length,
        itemBuilder: (context, index) {
          final teacherAd = teacherAds[index];
          return GestureDetector(
            onTap: () {
              // final controller = Get.find<TeachersPreviewController>();
              // controller.teacherAds.clear();
              // controller.teacherAds.add(teacherAd);
              // Get.toNamed(AppRoutes.teacherPreview);
            },
            child: SizedBox(
              child: Card(
                color: AppTheme.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FractionalStarRating(
                            rating: 1,
                          ),
                        ),
                      ],
                    ),
                    verticalGap(5),
                    CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      child: ImageWidget(image: AppImages.boy),
                    ),
                    verticalGap(10),
                    Text(
                      "${teacherAd.teacherName}\n${teacherAd.subjectName}",
                      style: TextStyles.black413.copyWith(fontSize: 13.sp),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdsView extends StatelessWidget {
  final bool isStudent;
  final List<StudentAd> studentAds;
  final List<TeacherAd> teacherAds;

  const AdsView({
    super.key,
    required this.isStudent,
    required this.studentAds,
    required this.teacherAds,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isStudent
            ? StudentAdsWidget(studentAds: studentAds)
            : TeacherAdsWidget(teacherAds: teacherAds),
      ],
    );
  }
}

bool isStudent() {
  return SharedPref.sharedPreferences.getString("user_type") == "student";
}
