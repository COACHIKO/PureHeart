import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_theme.dart';

class TripsChooseWidget extends StatelessWidget {
  const TripsChooseWidget({
    super.key,
    this.text,
    this.textColor,
    this.onTap,
  });
  final String? text;
  final Color? textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width * .27,
        height: context.height * .041,
        decoration: BoxDecoration(
            color: AppTheme.primaryLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.primaryLightColor)),
        child: Center(
          child: Text(
            text.toString().tr,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: textColor),
          ),
        ),
      ),
    );
  }
}
