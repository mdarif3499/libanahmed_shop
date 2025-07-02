import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_constant.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppInputWidget extends StatefulWidget {
  const AppInputWidget({
    super.key,
    this.hintText,
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isPassWordSecondValidation = false,
    this.isPassWordSecondValidationController,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.readOnly = false,
    this.isPhoneNumber = false,
    this.border,
    this.errBorder,
    this.titleColor,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.maxLines,
    this.onFieldSubmitted,
    this.onTap,
    this.filled = true,
    this.hintStyle,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.autoFocus = false,
    this.inputFormatters,
    this.cursorColor,
    this.labelStyle,
    this.labelText,
    this.alignLabelWithHint,
    this.borderColor,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.constraints,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.top,
    this.focusNode,
    this.autofillHints,
    this.validator,
  });

  final String? hintText;
  final String? labelText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool isPhoneNumber;
  final bool isPassWordSecondValidation;
  final TextEditingController? isPassWordSecondValidationController;
  final bool readOnly;
  final bool isEmail;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor;
  final bool filled;
  final Color? titleColor;
  final Color? cursorColor;
  final Color? borderColor;
  final double elevation;
  final Color? elevationColor;
  final int minLines;
  final int? maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? constraints;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool? alignLabelWithHint;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;

  @override
  State<AppInputWidget> createState() => _AppInputWidgetState();
}

class _AppInputWidgetState extends State<AppInputWidget> {
  bool isShowPassWord = true;

  @override
  Widget build(BuildContext context) {
    // Ensure that the password field does not use multiple lines when `obscureText` is true
    bool isObscure = widget.isPassWord && isShowPassWord;
    bool isSingleLine = widget.maxLines == 1;

    // Enforce that obscureText is only used with single-line text fields
    if (isObscure && !isSingleLine) {
      isObscure = false; // Disable obscureText for multiline fields
    }

    return TextFormField(
      focusNode: widget.focusNode,
      textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
      textAlign: widget.textAlign,
      textCapitalization: widget.textCapitalization,
      cursorColor: widget.cursorColor ?? AppColors.instance.primary500,
      autofocus: widget.autoFocus,
      inputFormatters: widget.inputFormatters,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted ?? (value) {},
      readOnly: widget.readOnly,
      controller: widget.controller ?? TextEditingController(),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }

            if (widget.isPassWord && value.length < 8) {
              return "Must be at least 8 characters.";
            }

            if (widget.isPhoneNumber && value.length < 10) {
              return "Must be at least 10 digits.";
            }

            if (widget.isEmail) {
              if (!GetUtils.isEmail(value)) {
                return "Please provide a valid email address";
              }
            }

            if (widget.isPassWord && widget.isPassWordSecondValidation) {
              final secondPass =
                  widget.isPassWordSecondValidationController?.text;
              if (secondPass != null && value != secondPass) {
                return "Both passwords must match";
              }
            }

            return null;
          },
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: isObscure,
      // Set the correct value for obscureText
      obscuringCharacter: "*",
      style: widget.style ??
          TextStyle(
              height: 2,
              fontFamily: AppConstant.instance.font,
              fontWeight: FontWeight.w500),
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        constraints: widget.constraints,
        alignLabelWithHint: widget.alignLabelWithHint,
        hoverColor: AppColors.instance.transparent,
        errorStyle: TextStyle(
            color: AppColors.instance.error.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
            fontFamily: AppConstant.instance.font,
            fontSize: 14),
        contentPadding:
            widget.contentPadding ?? EdgeInsets.all(AppSize.width(value: 10.0)),
        filled: widget.filled,
        fillColor: widget.fillColor ?? AppColors.instance.boxBg,
        prefixIcon: widget.prefix,
        prefixIconConstraints: widget.prefixIconConstraints ??
            BoxConstraints.tightFor(width: 24, height: 24),
        suffixIconConstraints: widget.suffixIconConstraints ??
            BoxConstraints.tightFor(width: 24, height: 24),
        suffixIcon: widget.isPassWord
            ? IconButton(
                color: Color(0xffA1A1A1),
                padding: EdgeInsets.zero,
                highlightColor: AppColors.instance.white500,
                onPressed: () {
                  setState(() {
                    isShowPassWord = !isShowPassWord;
                  });
                },
                icon: isShowPassWord
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : widget.suffixIcon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle: widget.hintStyle ??
            Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.instance.dark300),
        labelStyle: widget.hintStyle ??
            Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.instance.dark300,
                fontFamily: AppConstant.instance.font),
        border: widget.border ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(AppSize.width(value: 8.0)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.instance.dark300)),
        enabledBorder: widget.border ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(AppSize.width(value: 8.0)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.instance.dark300)),
        focusedBorder: widget.border ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(AppSize.width(value: 8.0)),
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.instance.dark300)),
        errorBorder: widget.errBorder ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(AppSize.width(value: 8.0)),
                borderSide: BorderSide(color: AppColors.instance.error)),
        focusedErrorBorder: widget.errBorder ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(AppSize.width(value: 8.0)),
                borderSide: BorderSide(color: AppColors.instance.error)),
      ),
    );
  }
}
