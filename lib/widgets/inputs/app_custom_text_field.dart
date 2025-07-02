import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? prefixIconPath; // SVG asset path for prefix icon
  final String? suffixIconPath; // SVG asset path for suffix icon
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final double borderRadius;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? fillColor;
  final bool filled;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? navigationRoute; // Route to navigate when field is tapped
  final Map<String, dynamic>? navigationArguments; // Arguments for navigation
  final bool readOnly;
  final bool enabled;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double? borderWidth;
  final InputBorder? border; // Custom border
  final InputBorder? errBorder; // Custom error border
  final BorderRadius? borderRadiusCustom; // Custom border radius

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIconPath,
    this.suffixIconPath,
    this.prefixIconColor,
    this.suffixIconColor,
    this.prefixIconSize = 24.0,
    this.suffixIconSize = 24.0,
    this.borderRadius = 8.0,
    this.borderColor,
    this.focusedBorderColor,
    this.fillColor,
    this.filled = true, // Changed default to true
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.navigationRoute,
    this.navigationArguments,
    this.readOnly = false,
    this.enabled = true,
    this.validator,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.borderWidth = 1.0,
    this.border,
    this.errBorder,
    this.borderRadiusCustom,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      onTap: () {
        // Handle navigation if route is provided
        if (navigationRoute != null) {
          Get.toNamed(
            navigationRoute!,
            arguments: navigationArguments,
          );
        }
        // Call custom onTap if provided
        if (onTap != null) {
          onTap!();
        }
      },
      readOnly: readOnly,
      enabled: enabled,
      validator: validator,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
      // Set cursor color
      cursorColor: AppColors.instance.black500,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 12.0,
          color: AppColors.instance.black200,
          fontWeight: FontWeight.w400,
        ),
        filled: filled,
        fillColor: fillColor ?? AppColors.instance.white200,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),

        // Prefix Icon
        prefixIcon: prefixIconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  prefixIconPath!,
                  width: prefixIconSize,
                  height: prefixIconSize,
                ),
              )
            : null,

        // Suffix Icon
        suffixIcon: suffixIconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  suffixIconPath!,
                  width: suffixIconSize,
                  height: suffixIconSize,
                ),
              )
            : null,

        // Applied border styling from the provided code
        border: border ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.instance.dark300),
            ),
        enabledBorder: border ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.instance.dark300),
            ),
        focusedBorder: border ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: focusedBorderColor ??
                      borderColor ??
                      AppColors.instance.dark300),
            ),
        errorBorder: errBorder ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppColors.instance.error),
            ),
        focusedErrorBorder: errBorder ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppColors.instance.error),
            ),
        disabledBorder: border ??
            OutlineInputBorder(
              borderRadius:
                  borderRadiusCustom ?? BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: borderColor ?? AppColors.instance.dark300),
            ),
      ),
    );
  }
}
