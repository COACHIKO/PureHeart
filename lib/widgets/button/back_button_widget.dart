import 'package:flutter/material.dart';

import '../../core/utils/app_theme.dart';

class BackButtonWidget extends StatelessWidget {
  BackButtonWidget({
    this.onTap,
    super.key,
    this.iconColor,
  });

  Function()? onTap;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: onTap,
        iconSize: 24,
        icon: Icon(
          Icons.arrow_back,
          color: iconColor ?? AppTheme.white,
        ));
  }
}
