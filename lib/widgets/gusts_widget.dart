import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_images.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/gaps.dart';

import '../core/utils/text_styles.dart';
import 'image/image_widget.dart';

class GustsWidget extends StatelessWidget {
  const GustsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .83,
      child: Row(
        children: [
          Text(
            "Capacity".tr,
            style: TextStyles.primary312,
          ),
          Spacer(),
          Container(
            width: context.width * .05,
            height: 18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppTheme.grey)),
            child: Center(
                child: Text(
              '-',
              style: TextStyle(color: AppTheme.grey),
            )),
          ),
          horizontalGap(20),
          Text(
            "200",
            style: TextStyles.secondary414,
          ),
          horizontalGap(20),
          Container(
            width: context.width * .05,
            height: 18,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppTheme.primaryColor)),
            child: Center(
                child: Text(
              '+',
              style: TextStyle(color: AppTheme.primaryColor),
            )),
          ),
        ],
      ),
    );
  }
}
