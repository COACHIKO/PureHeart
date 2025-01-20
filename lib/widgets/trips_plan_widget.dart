import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_icons.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/gaps.dart';

import 'image/svg_image_widget.dart';

import '../core/utils/text_styles.dart';

class TripsPlanWidget extends StatelessWidget {
  const TripsPlanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .86,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.primaryLightColor),
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
      child: Row(
        children: [
          SvgImageWidget(
            image: AppIcons.car1,
          ),
          horizontalGap(18),
          SizedBox(
              width: context.width * .61,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rent a car".tr,
                    style: TextStyles.primary512,
                  ),
                  Text(
                    "Pick-up at Nouakchott International Airport".tr,
                    style: TextStyles.primary410,
                  )
                ],
              )),
          Spacer(),
          SvgImageWidget(
            image: AppIcons.arrowForward,
          )
        ],
      ),
    );
  }
}
