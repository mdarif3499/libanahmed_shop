import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppImageButton extends StatelessWidget {
  const AppImageButton({
    super.key,
    this.height,
    this.width,
    this.alignment,
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
    this.image,
    this.svgPath, // New SVG path parameter
    this.imageSize,
    this.imagePosition = ImagePosition.left,
    this.imageTitleSpacing,
  });

  final double? loadingSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final Decoration? decoration;
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
  final Widget? image;
  final String? svgPath; // New SVG path parameter
  final double? imageSize;
  final ImagePosition imagePosition;
  final double? imageTitleSpacing;

  @override
  Widget build(BuildContext context) {
    // Determine which image widget to use (SVG or regular image)
    Widget? imageWidget;
    if (svgPath != null) {
      imageWidget = SvgPicture.asset(
        svgPath!,
        width: imageSize ?? AppSize.width(value: 24),
        height: imageSize ?? AppSize.width(value: 24),
      );
    } else if (image != null) {
      imageWidget = SizedBox(
        width: imageSize ?? AppSize.width(value: 24),
        height: imageSize ?? AppSize.width(value: 24),
        child: image,
      );
    }

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
                borderradius ?? AppSize.width(value: 8.0),
              ),
            ),
        child: isLoading
            ? SizedBox(
                width: loadingSize ?? Get.height * 0.04,
                height: loadingSize ?? Get.height * 0.04,
                child: CircularProgressIndicator(
                  color: loaderColor ?? AppColors.instance.white50,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (imageWidget != null &&
                      imagePosition == ImagePosition.left) ...[
                    imageWidget,
                    if (title != null)
                      SizedBox(
                        width: imageTitleSpacing ?? AppSize.width(value: 8),
                      ),
                  ],
                  if (title != null)
                    AppText(
                      text: title!,
                      color: titleColor ?? AppColors.instance.white50,
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize ?? 14,
                    ),
                  if (imageWidget != null &&
                      imagePosition == ImagePosition.right) ...[
                    if (title != null)
                      SizedBox(
                        width: imageTitleSpacing ?? AppSize.width(value: 8),
                      ),
                    imageWidget,
                  ],
                ],
              ),
      ),
    );
  }
}

enum ImagePosition { left, right }
