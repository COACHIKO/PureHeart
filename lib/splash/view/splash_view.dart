import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/gaps.dart';
import '../../core/utils/text_styles.dart';
import '../../widgets/image/image_widget.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    return Scaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWidget(
                image: AppImages.logo,
                fit: BoxFit.cover,
                width: context.width * .5,
              ),
              verticalGap(20),
              Text(
                "الطالب يتحدي المستحيل",
                style: TextStyles.primary712
                    .copyWith(wordSpacing: 5, fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
