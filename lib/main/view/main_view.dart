import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pureheartapp/core/utils/gaps.dart';
import 'package:pureheartapp/widgets/custom_navigation_bar.dart';
import '../../core/utils/text_styles.dart';
import '../controller/main_controller.dart';
import 'widgets/ads_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/subjects_widget.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const HeaderWidget(),
                verticalGap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdsWidget(controller: controller),
                    Column(
                      children: [
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (!controller.showSideNumbers.value)
                                  SizedBox(height: 300.w),
                                if (controller.showSideNumbers.value)
                                  Container(
                                    height: 260.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      border: Border.all(color: Colors.orange),
                                    ),
                                    child: ListView.builder(
                                      itemCount: 15,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.selectedUnit.value =
                                                index + 1;
                                            controller.getStudents(controller
                                                .subjects[controller
                                                    .selectedItemIndex.value]
                                                .id
                                                .toString());
                                          },
                                          child: Obx(
                                            () => Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: TextStyles.white614
                                                        .copyWith(
                                                      fontSize: 22.sp,
                                                      color: controller
                                                                      .selectedUnit
                                                                      .value -
                                                                  1 ==
                                                              index
                                                          ? Colors.orange
                                                          : Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                if (index < 14)
                                                  Divider(
                                                    color: Colors.orange,
                                                    thickness: 1,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            )),
                        verticalGap(20.h),
                        GestureDetector(
                          onTap: () {
                            controller.showSideNumbers.value =
                                !controller.showSideNumbers.value;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "الفصل",
                              style: TextStyles.white614.copyWith(
                                fontSize: 14.sp,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalGap(20),
                SubjectsWidget(controller: controller),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
