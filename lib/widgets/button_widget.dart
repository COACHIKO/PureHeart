import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/app_theme.dart';
import '../core/utils/text_styles.dart';

class ButtonWidget extends StatefulWidget {
  final Function()? onPressFunction;
  final String? stringText;
  final Color? color;
  final Color? tColor;

  final double? width, height;
  final bool arrowForward;
  final bool isLoading;

  const ButtonWidget(
      {super.key,
      this.onPressFunction,
      this.color,
      this.tColor,
      this.stringText,
      this.height,
      this.width,
      this.arrowForward = false,
      this.isLoading = false});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressFunction,
      child: Container(
        width: widget.width ?? context.width * .82,
        height: widget.height ?? context.height * .0575,
        decoration: BoxDecoration(
            gradient: widget.color == null ? AppTheme.gradientColor : null,
            color: widget.color,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: widget.isLoading
            ? Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Row(
                children: [
                  const Spacer(),
                  Text(widget.stringText.toString().tr,
                      style: TextStyles.white720.copyWith(
                          fontSize: 17.sp,
                          color: widget.tColor ?? AppTheme.white)),
                  const Spacer(),
                  widget.arrowForward == true
                      ? Icon(Icons.arrow_forward_ios,
                          color: AppTheme.white, size: 12.sp)
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }
}
