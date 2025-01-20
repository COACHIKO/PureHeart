import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/utils/app_icons.dart';
import '../../core/utils/text_styles.dart';

import '../image/svg_image_widget.dart';

import '../../core/utils/app_theme.dart';
import '../../core/utils/gaps.dart';

class PhoneTextFieldWidget extends StatelessWidget {
  const PhoneTextFieldWidget({
    this.countryOnChanged,
    this.controller,
    this.hintText,
    this.iconPath,
    super.key,
  });

  final Function(CountryCode)? countryOnChanged;
  final TextEditingController? controller;
  final String? hintText, iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * .82,
      height: context.height * .066,
      padding: const EdgeInsets.only(right: 15, left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.primaryLightColor),
      child: Row(
        children: [
          CountryCodePicker(
              initialSelection: "+222",
              textStyle: TextStyles.primary614,
              showFlagMain: false,
              padding: const EdgeInsets.all(0),
              onChanged: countryOnChanged),
          horizontalGap(15),
          Expanded(
              child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: controller,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              filled: false,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 13,
              ),
              hintStyle: TextStyles.primary314,
              hintText: hintText,
              border: InputBorder.none,
            ),
          )),
          SvgImageWidget(
            image: iconPath,
            height: 24,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

class StaticPhoneWidget extends StatelessWidget {
  const StaticPhoneWidget({
    this.controller,
    this.hintText,
    this.iconPath,
    this.onChanged,
    super.key,
    this.countryOnChanged,
  });

  final Function(CountryCode)? countryOnChanged;
  final TextEditingController? controller;
  final String? hintText, iconPath;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalGap(5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFc5c6ec)),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                // Country Code Picker
                CountryCodePicker(
                  onChanged: (CountryCode countryCode) {
                    // Correctly invoking the callback
                    countryOnChanged?.call(countryCode);
                  },
                  initialSelection: "+222",
                  showFlag: true,
                  showFlagMain: true,
                  showFlagDialog: true,
                  textStyle: const TextStyle(
                    color: Color(0xFFaaabdd),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 1,
                  height: 30,
                  color: AppTheme.primaryColor,
                ),
                // Text Field
                Expanded(
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      hintStyle: const TextStyle(
                        color: Color(0xFFaaabdd),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WhatsappPhone extends StatelessWidget {
  const WhatsappPhone({
    this.controller,
    this.hintText,
    this.iconPath,
    super.key,
    this.countryOnChanged,
  });

  final Function(CountryCode)? countryOnChanged;
  final TextEditingController? controller;
  final String? hintText, iconPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalGap(5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFc5c6ec)),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const SvgImageWidget(
                  image: AppIcons.whatsappIcon,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                CountryCodePicker(
                  onChanged: ((value) => countryOnChanged),
                  initialSelection: "+222",
                  showFlag: false,
                  showFlagDialog: true,
                  textStyle: const TextStyle(
                    color: Color(0xFFaaabdd),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  padding: const EdgeInsets.all(0),
                ),
                Expanded(
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    controller: controller,
                    decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                      hintStyle: const TextStyle(
                        color: Color(0xFFaaabdd),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
