import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_theme.dart';
import '../../core/utils/text_styles.dart';

class InmaaTextFieldWidget extends StatelessWidget {
  const InmaaTextFieldWidget({
    this.hintText,
    this.width,
    this.suffix,
    this.keyboardType,
    this.readOnly,
    this.controller,
    this.maxLines,
    this.minLines,
    this.validator,
    this.onChanged,
    super.key,
  });

  final String? hintText;
  final double? width;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final TextEditingController? controller;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width * .83,
      // height: context.height * .046,
      child: TextFormField(
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
        controller: controller,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        textAlignVertical: TextAlignVertical.center,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                suffix ?? SizedBox(),
              ],
            ),
          ),
          fillColor: AppTheme.primaryLightColor,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 29,
          ),
          hintStyle: TextStyles.primary314,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryLightColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryLightColor)),
        ),
      ),
    );
  }
}
