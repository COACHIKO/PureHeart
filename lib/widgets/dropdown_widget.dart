import 'package:flutter/material.dart';
import '../core/utils/app_icons.dart';
import '../core/utils/app_theme.dart';

import '../core/utils/text_styles.dart';
import 'image/svg_image_widget.dart';

// ignore: must_be_immutable
class DropDownWidget extends StatelessWidget {
  Object? value;
  List<DropdownMenuItem<Object>>? items;
  void Function(dynamic)? onChanged;
  bool? isExpanded;
  TextStyle? style;
  String? hint;
  double? width, height, textPadding;

  DropDownWidget(
      {super.key,
      this.items,
      this.value,
      this.isExpanded,
      this.onChanged,
      this.style,
      this.width,
      this.textPadding,
      this.hint,
      this.height});

  @override
  Widget build(BuildContext context) {
    bool isValueInItems = items != null &&
        (value == null || items!.any((item) => item.value == value));

    if (!isValueInItems) {
      value = null;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.grey)),
      child: Center(
        child: DropdownButton(
          padding: EdgeInsets.symmetric(horizontal: textPadding ?? 11),
          isExpanded: isExpanded ?? true,
          value: value,
          style: style ?? TextStyles.primary314,
          underline: SizedBox(),
          iconSize: 7,
          hint: Text(
            hint ?? "",
            style: style,
          ),
          icon: SvgImageWidget(
            image: AppIcons.arrowDown,
            fit: BoxFit.cover,
          ),
          items: items!,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
