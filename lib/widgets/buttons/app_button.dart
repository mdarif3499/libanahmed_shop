import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.height,
    this.width,
    this.alignment,
    this.child,
    this.decoration,
    this.onTap,
    this.padding,
    this.title,
    this.isLoading = false,
    this.loaderColor,
    this.margin,
    this.backgroundColor,
    this.loadingSize,
    this.titleColor,
    this.border,
    this.borderColor,
    this.borderradius,
    this.fontSize,
  });

  final double? loadingSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;
  final Widget? child;
  final String? title;
  final void Function()? onTap;
  final bool isLoading;
  final Color? titleColor;
  final Color? loaderColor;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Color? borderColor;
  final double? borderradius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: Durations.long1,
        curve: Curves.ease,
        width: width,
        height: height ?? AppSize.height(value: 48),
        alignment: alignment ?? Alignment.center,
        margin: margin,
        padding: padding ?? EdgeInsets.all(AppSize.width(value: 5.0)),
        decoration:
            decoration ??
            BoxDecoration(
              color: backgroundColor ?? AppColors.instance.primary,
              border: borderColor != null
                  ? Border.all(color: borderColor!)
                  : null,
              borderRadius: BorderRadius.circular(
                borderradius ?? AppSize.width(value: AppSize.width(value: 8.0)),
              ),
            ),
        child: isLoading
            ? SizedBox(
                width: loadingSize ?? Get.height * 0.04,
                height: loadingSize ?? Get.height * 0.04,
                child: LoadingAnimationWidget.progressiveDots(
                  color: AppColors.instance.white,
                  size: loadingSize ?? Get.height * 0.04,
                ),
              )
            : child ??
                  AppText(
                    text: title ?? "",
                    color: titleColor ?? AppColors.instance.white50,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize ?? 14,
                  ),
      ),
    );
  }
}
