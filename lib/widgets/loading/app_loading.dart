import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:flutter/material.dart';

Widget appLoading({double? width, double? height, Color? loaderColor}) {
  return Center(
    child: SizedBox(width: width ?? AppSize.width(value: 50), height: height ?? AppSize.width(value: 50), child: CircularProgressIndicator(color: loaderColor ?? AppColors.instance.primary)),
  );
}
