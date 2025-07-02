import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/inputs/app_input_widget_tow.dart';

class OwnerMenuRatings extends StatelessWidget {
  const OwnerMenuRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.ratings,
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppText(
              text: AppString.instance.feelFree,
              color: AppColors.instance.grey800,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            Container(
              width: AppSize.width(value: 335),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: AppColors.instance.authBorderColor)),
              child: Column(
                children: [
                  AppText(
                    text: AppString.instance.giveYourRating,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    fontFamily: 2,
                    color: AppColors.instance.textColor,
                  ),
                  Gap(
                    height: 20,
                  ),
                  RatingBar.builder(
                    itemSize: 40,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: AppColors.instance.ratingBar,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Gap(
                    height: 10,
                  ),
                  AppInputReview(
                    hintText: "Write a review here...",
                    fillColor: AppColors.instance.white50,
                    // Custom fill color
                    borderColor: AppColors.instance.grey300,
                    // Custom border color
                    controller: TextEditingController(),
                  ),
                  Gap(
                    height: 20,
                  ),
                  AppButton(
                    backgroundColor: AppColors.instance.red500,
                    titleColor: AppColors.instance.white50,
                    title: AppString.instance.submit,
                    onTap: () {},
                    height: AppSize.height(value: 52),
                  ),
                  Gap(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
