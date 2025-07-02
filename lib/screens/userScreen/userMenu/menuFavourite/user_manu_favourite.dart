import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserManuFavourite extends StatelessWidget {
  const UserManuFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.myFavorites,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: List.generate(6, (index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColors.instance.green50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    AppAssertImage.instance.appleJuice,
                    height: AppSize.height(value: 65),
                    width: AppSize.width(value: 65),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppString.instance.appleJuice,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: AppColors.instance.textColor,
                      ),
                      // Gap(
                      //   height: 08,
                      // ),
                      AppText(
                        text: AppString.instance.twoLiters,
                        color: AppColors.instance.greyTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      // Gap(
                      //   height: 8,
                      // ),
                      AppText(
                        text: AppString.instance.fifteen,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: AppColors.instance.textColor,
                      ),
                    ],
                  ),
                  SvgPicture.asset(AppAssertIcons.favFill)
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
