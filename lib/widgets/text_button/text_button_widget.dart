import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/text_styles.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({this.text, this.onPressFunction, super.key});

  final Function()? onPressFunction;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressFunction,
        child: Text(
          text.toString().tr,
          style: TextStyles.primary409,
        ));
  }
}
