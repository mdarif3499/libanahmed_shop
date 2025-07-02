import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProductDetailsScreen extends StatelessWidget {
  const UserProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: AppSize.height(value: 275),
              decoration: BoxDecoration(
                color: AppColors.instance.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(AppAssertImage.instance.apple),
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: AppColors.instance.green50,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AppAssertIcons.favFill),
                ),
              ),
            ),
            Gap(height: 20),
            Row(
              children: [
                AppText(
                  text: AppString.instance.nineEight,
                  fontSize: 24,
                  fontFamily: 1,
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.green500,
                ),
                Gap(
                  width: 3,
                ),
                AppText(
                  text: AppString.instance.five00Gram,
                  fontSize: 16,
                  fontFamily: 1,
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.white900,
                ),
                Gap(
                  width: 65,
                ),
                AppButton(
                  height: AppSize.height(value: 35),
                  width: AppSize.width(value: 35),
                  title: "+",
                  titleColor: AppColors.instance.white,
                  backgroundColor: AppColors.instance.green500,
                  onTap: () {},
                ),
                Gap(
                  width: 8,
                ),
                Container(
                  height: AppSize.height(value: 35),
                  width: AppSize.width(value: 53),
                  decoration: BoxDecoration(
                    color: AppColors.instance.blue2_50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: AppText(
                      text: "1",
                      fontWeight: FontWeight.w400,
                      fontFamily: 1,
                      fontSize: 16,
                    ),
                  ),
                ),
                Gap(
                  width: 8,
                ),
                AppButton(
                  height: AppSize.height(value: 35),
                  width: AppSize.width(value: 35),
                  title: "-",
                  titleColor: AppColors.instance.white,
                  backgroundColor: AppColors.instance.green500,
                  onTap: () {},
                ),
              ],
            ),
            Gap(height: 20),
            AppText(
              text: AppString.instance.freshStrawberry,
              fontSize: 18,
              fontFamily: 1,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppText(
              text: AppString.instance.productDetails,
              fontSize: 16,
              fontFamily: 1,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppText(
              text: AppString.instance.every500Gram,
              fontWeight: FontWeight.w500,
              fontFamily: 1,
              fontSize: 15,
              maxLines: 8,
              textAlign: TextAlign.justify,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  width: AppSize.width(value: 150),
                  titleColor: AppColors.instance.green500,
                  title: AppString.instance.buyNow,
                  backgroundColor: AppColors.instance.white,
                  borderColor: AppColors.instance.green500,
                  onTap: () {},
                ),
                AppButton(
                  width: AppSize.width(value: 150),
                  titleColor: AppColors.instance.white,
                  title: AppString.instance.addCart,
                  backgroundColor: AppColors.instance.green500,
                  borderColor: AppColors.instance.white,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
