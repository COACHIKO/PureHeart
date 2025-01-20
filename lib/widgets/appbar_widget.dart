import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_icons.dart';
import '../core/utils/app_images.dart';
import '../core/utils/app_routes.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/gaps.dart';

import '../core/utils/text_styles.dart';
import 'image/image_widget.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget(
      {this.title,
      this.onTap,
      this.skipOnTap,
      this.skipButton = false,
      this.backColor,
      this.iconColor,
      super.key});

  final String? title;
  final Function()? onTap;
  final Function()? skipOnTap;
  final bool skipButton;
  final Color? backColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor ?? AppTheme.white,
      elevation: 0,
      leading: IconButton(
          onPressed: onTap,
          iconSize: 24,
          icon: Icon(
            Icons.arrow_back,
            color: iconColor ?? AppTheme.primaryColor,
          )),
      title: Text(
        title ?? "",
        style: TextStyles.primary824,
      ),
      centerTitle: true,
      actions: [
        skipButton == true
            ? TextButton(
                onPressed: skipOnTap,
                child: Text(
                  "Skip".tr,
                  style: TextStyles.primary512,
                ),
              )
            : SizedBox()
      ],
    );
  }
}
