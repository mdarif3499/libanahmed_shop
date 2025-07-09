import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerEditProduct extends StatelessWidget {
  const OwnerEditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.productDetails,
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
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use a flexible height for the container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.instance.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(AppAssertImage.instance.apple),
                  fit: BoxFit.cover, // Ensure the image scales properly
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: AppColors.instance.red50,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AppAssertIcons.favEmpty),
                ),
              ),
            ),
            const Gap(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: AppString.instance.naturelRedApple,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: AppColors.instance.textColor,
                  fontFamily: 2,
                ),
                AppText(
                  text: AppString.instance.fourDollar,
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: AppColors.instance.textColor,
                  fontFamily: 2,
                ),
              ],
            ),
            const Gap(height: 10),
            AppText(
              text: AppString.instance.oneKg,
              fontSize: 16,
              fontFamily: 1,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.greyTextColor,
            ),
            const Gap(height: 10),
            AppText(
              text: AppString.instance.every500Gram,
              fontSize: 14,
              fontFamily: 1,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.textColor,
              textAlign: TextAlign.justify,
              maxLines: 5,
            ),
            const Gap(height: 50),
            AppButton(
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.red500,
              title: AppString.instance.editProduct,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
