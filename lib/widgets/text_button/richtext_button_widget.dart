import 'package:flutter/material.dart';

import '../../core/utils/text_styles.dart';

class RichtextButtonWidget extends StatelessWidget {
  const RichtextButtonWidget(
      {this.text1, this.text2, this.onPressFunction, super.key});

  final Function()? onPressFunction;
  final String? text1, text2;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressFunction,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: "$text1", style: TextStyles.secondary512),
          TextSpan(text: "$text2", style: TextStyles.primary712)
        ]),
      ),
    );
  }
}
