import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/app_theme.dart';

import 'package:pinput/pinput.dart';

class PinInputWidget extends StatelessWidget {
  const PinInputWidget({
    this.controller,
    super.key,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 4,
      keyboardType: TextInputType.number,
      cursor: Container(
          width: 2, height: context.height * .02, color: AppTheme.primaryColor),
      defaultPinTheme: PinTheme(
        width: context.width * .1,
        height: context.height * .045,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.grey.shade50,
        ),
      ),
      focusedPinTheme: PinTheme(
        width: context.width * .1,
        height: context.height * .045,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: AppTheme.primaryColor),
        ),
      ),
      controller: controller,
    );
  }
}
