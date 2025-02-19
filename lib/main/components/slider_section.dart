import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/text_styles.dart';
import '../../core/utils/gaps.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/image/image_widget.dart';

class SliderSection extends StatelessWidget {
  const SliderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: context.width * 0.7,
          height: 430,
          child: PageView.builder(
            itemCount: 5,
            controller: PageController(viewportFraction: 1),
            itemBuilder: (context, index) => _buildSliderItem(context, index),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderItem(BuildContext context, int index) {
    return AnimatedBuilder(
      animation: PageController(viewportFraction: 0.8),
      builder: (context, child) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: child,
          ),
        );
      },
      child: _buildSliderCard(index),
    );
  }

  Widget _buildSliderCard(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(23)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildImageSection(index),
          verticalGap(25.h),
          _buildInfoSection(),
          verticalGap(30),
          ButtonWidget(
            height: 40,
            width: 250,
            tColor: Colors.black,
            stringText: "موافق",
            color: Color(0xFFB8E945),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            color: Colors.black,
          ),
          child: ImageWidget(
            fit: BoxFit.fill,
            image: AppImages.doctor,
            width: double.infinity,
            height: 438 / 2,
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            (4.6 + index).toString(),
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

  Widget _buildInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTimeInfo(),
        Container(
          width: 1,
          height: 70.h,
          color: Colors.black,
        ),
        _buildPriceInfo(),
      ],
    );
  }

  Widget _buildTimeInfo() {
    return Column(
      children: [
        ImageWidget(
          image: AppImages.time,
          width: 60,
          height: 60,
        ),
        verticalGap(5),
        Text(
          "00.00.00",
          style: TextStyles.black714.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
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
              " 1000",
              style: TextStyles.black714.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}
