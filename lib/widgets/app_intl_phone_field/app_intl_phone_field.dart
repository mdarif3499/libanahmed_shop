import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../utils/app_size.dart';

class IntlPhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String initialCountryCode;
  final String hintText;
  final ValueChanged<PhoneNumber>? onChanged;
  final Color? borderColor;
  final Color? fillColor;

  const IntlPhoneFieldWidget({
    super.key,
    required this.controller,
    this.initialCountryCode = 'BD',
    this.hintText = '',
    this.onChanged,
    this.borderColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.initialize(context);

    final Color effectiveBorderColor =
        borderColor ?? AppColors.instance.createOrderTextFieldBorder;
    final Color effectiveFillColor =
        fillColor ?? AppColors.instance.createOrderTextFiledFill;

    return IntlPhoneField(
      controller: controller,
      flagsButtonPadding: EdgeInsets.only(left: ResponsiveUtils.width(10)),
      dropdownTextStyle: const TextStyle(color: Colors.black),
      dropdownIconPosition: IconPosition.leading,
      dropdownIcon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.blueGrey,
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: effectiveFillColor,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.instance.black200,
          fontWeight: FontWeight.w400,
          fontSize: ResponsiveUtils.width(15),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: effectiveBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: effectiveBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: effectiveBorderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.instance.red500,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.instance.red300,
          ),
        ),
      ),
      initialCountryCode: initialCountryCode,
      onChanged: onChanged,
    );
  }
}
