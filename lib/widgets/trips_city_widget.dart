import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_images.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/gaps.dart';

import '../core/utils/text_styles.dart';
import 'image/image_widget.dart';

class TripsCityWidget extends StatelessWidget {
  const TripsCityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .86,
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: const [
          BoxShadow(
            color: AppTheme.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          ImageWidget(
            image: AppImages.khaima,
            height: context.height * .086,
          ),
          horizontalGap(18),
          SizedBox(
            height: context.height * .086,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Al Khaima City Center",
                  style: TextStyles.primary512,
                ),
                Text(
                  "Oct 15 Oct 18 € 130.50",
                  style: TextStyles.grey409,
                ),
                Spacer(),
                Text(
                  "Confirmed".tr,
                  style: TextStyles.primary614,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
