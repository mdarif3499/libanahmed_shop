import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_constant.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';

class AppInputReview extends StatefulWidget {
  const AppInputReview({
    super.key,
    this.title,
    this.subTitle,
    this.hintText = "",
    this.labelText = "",
    this.prefix,
    this.suffixIcon,
    this.isPassWord = false,
    this.isEmail = false,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType,
    this.fillColor,
    this.borderColor, // Add borderColor parameter
    this.elevation = 0.0,
    this.elevationColor,
    this.minLines = 1,
    this.maxLines = 5,
    this.readOnly = false,
    this.isOptional = false,
    this.border,
    this.errBorder,
    this.titleColor,
    this.onTap,
    this.style,
    this.hintStyle,
    this.padding,
    this.contentPadding,
    this.inputType = InputType.suggestion, // default type is suggestion
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIconConstraints,
  });

  final String? title;
  final String? subTitle;
  final String hintText;
  final String labelText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool isPassWord;
  final bool readOnly;
  final bool isEmail;
  final bool isOptional;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? fillColor; // Fill color for the background
  final Color? borderColor; // Border color
  final double elevation;
  final Color? elevationColor;
  final int minLines;
  final int maxLines;
  final InputBorder? border;
  final InputBorder? errBorder;
  final void Function()? onTap;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool? alignLabelWithHint = false; // Default value of false
  final BoxConstraints? suffixIconConstraints;
  final InputType inputType;
  final Color? titleColor;

  @override
  _AppInputReviewState createState() => _AppInputReviewState();
}

enum InputType {
  suggestion,
  review,
  description,
}

class _AppInputReviewState extends State<AppInputReview> {
  bool isShowPassWord = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) const Gap(height: 15),
          if (widget.title != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppText(
                    text: widget.title ?? "",
                    fontWeight: FontWeight.w500,
                    color: widget.titleColor ?? AppColors.instance.dark200,
                    fontSize: 18),
                Padding(
                  padding: EdgeInsets.only(right: AppSize.width(value: 10.0)),
                  child: AppText(
                      text: widget.subTitle ?? "",
                      fontWeight: FontWeight.w400,
                      color: widget.titleColor ?? AppColors.instance.dark200,
                      fontSize: 14),
                ),
              ],
            ),
          if (widget.title != null) const Gap(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.width(value: 8.0)),
            child: TextFormField(
              textCapitalization: widget.textCapitalization,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              controller: widget.controller,
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: widget.isPassWord && isShowPassWord,
              obscuringCharacter: "*",
              style: widget.style ??
                  Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.instance.dark300,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                alignLabelWithHint: widget.alignLabelWithHint,
                hoverColor: AppColors.instance.transparent,
                filled: true,
                contentPadding: widget.contentPadding ??
                    EdgeInsets.all(AppSize.width(value: 15.0)),
                fillColor: widget.fillColor ?? AppColors.instance.boxBg,
                // Use fillColor
                prefixIcon: widget.prefix,
                suffixIcon: widget.suffixIcon,
                suffixIconConstraints: widget.suffixIconConstraints,
                hintText: widget.hintText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: widget.labelText,
                hintStyle: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.instance.dark300),
                labelStyle: widget.hintStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: AppColors.instance.dark300),
                errorStyle: TextStyle(
                    color: AppColors.instance.error,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstant.instance.font,
                    fontSize: 12),
                border: widget.border ??
                    OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.width(value: 8.0)),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              AppColors.instance.boxBg, // Use borderColor
                        )),
                enabledBorder: widget.border ??
                    OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.width(value: 8.0)),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              AppColors.instance.boxBg, // Use borderColor
                        )),
                focusedBorder: widget.border ??
                    OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.width(value: 8.0)),
                        borderSide: BorderSide(
                          color: widget.borderColor ??
                              AppColors.instance.boxBg, // Use borderColor
                        )),
                errorBorder: widget.errBorder ??
                    OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.width(value: 8.0)),
                        borderSide: BorderSide(
                          color: AppColors.instance.error,
                        )),
                focusedErrorBorder: widget.errBorder ??
                    OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppSize.width(value: 8.0)),
                        borderSide: BorderSide(
                          color: AppColors.instance.error,
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
