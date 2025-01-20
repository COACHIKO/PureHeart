import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_theme.dart';
import '../../core/utils/text_styles.dart';
import '../image/svg_image_widget.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    this.hintText,
    this.obscureText,
    this.readOnly,
    this.controller,
    this.iconPath,
    this.iconPressed,
    this.keyboardType,
    this.height,
    this.width,
    this.sufIcon = true,
    this.onTap,
    this.hintStyle,
    this.validator,
    super.key,
  });

  final String? hintText, iconPath;
  final bool? obscureText;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final double? height, width;
  final bool sufIcon;
  final TextStyle? hintStyle;

  final Function()? iconPressed, onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width * .82,
      // height: height ?? context.height * .066,
      child: TextFormField(
        onTap: onTap,
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.primaryLightColor,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          hintStyle: hintStyle ?? TextStyles.primary314,
          suffixIcon: sufIcon == true
              ? IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: iconPressed,
                  icon: SvgImageWidget(
                    image: iconPath,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                )
              : SizedBox(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.primaryLightColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppTheme.primaryLightColor)),
        ),
        style: TextStyles.primary314,
      ),
    );
  }
}
