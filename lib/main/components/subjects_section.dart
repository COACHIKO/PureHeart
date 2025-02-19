import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/text_styles.dart';
import '../../core/utils/gaps.dart';
import '../../widgets/image/image_widget.dart';
import '../controller/main_controller.dart';

class SubjectsSection extends StatelessWidget {
  const SubjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return SizedBox(
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
              height: 120.h,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.subjects.length,
                      itemBuilder: (context, index) =>
                          _buildSubjectItem(context, index, controller),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSubjectItem(
      BuildContext context, int index, MainController controller) {
    final subject = controller.subjects[index];
    return GestureDetector(
      onTap: () => controller.changeSelectedItemIndex(index),
      child: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: context.width * .10,
                backgroundColor: Colors.transparent,
                child: CircleAvatar(
                  radius: context.width * .09,
                  backgroundColor: controller.selectedItemIndex.value == index
                      ? Colors.orange
                      : Colors.white,
                  child: CircleAvatar(
                    radius: context.width * .08,
                    backgroundColor: Colors.black,
                    child: ImageWidget(
                      image: subject.icon,
                    ),
                  ),
                ),
              ),
              verticalGap(5),
              Text(
                subject.name,
                style: TextStyles.white409.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
