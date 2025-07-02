import 'dart:developer';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuRatings/controller/user_menu_ratings_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget_three.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserMenuRatings extends StatelessWidget {
  const UserMenuRatings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserMenuRatingsController());

    // Get arguments passed from previous screen - FIXED
    final arguments = Get.arguments as List?;
    final String? sellerId =
        arguments != null && arguments.length > 0 ? arguments[0] : null;
    final String? orderId =
        arguments != null && arguments.length > 1 ? arguments[1] : null;

    // Debug logging
    log("Arguments received: $arguments");
    log("Seller ID: $sellerId");
    log("Order ID: $orderId");

    // Initialize controller with the data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (sellerId != null && orderId != null) {
        controller.initializeData(sellerId, orderId);
      } else {
        log("Error: Missing sellerId or orderId");
        // You might want to show an error message or navigate back
      }
    });

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
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: Obx(() {
        // Check if review is already given
        if (controller.isReviewAlreadyGiven.value) {
          return Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColors.instance.white,
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: AppColors.instance.userPhoneBackground),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.instance.green500,
                    size: 60,
                  ),
                  Gap(height: 20),
                  AppText(
                    text: "Review Already Submitted",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.instance.textColor,
                    textAlign: TextAlign.center,
                  ),
                  Gap(height: 10),
                  AppText(
                    text:
                        "You have already given a review for this order. Thank you for your feedback!",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.grey800,
                    textAlign: TextAlign.center,
                  ),
                  Gap(height: 20),
                  AppButton(
                    backgroundColor: AppColors.instance.green500,
                    titleColor: AppColors.instance.white50,
                    title: "Go Back",
                    onTap: () {
                      Get.back();
                    },
                    height: AppSize.height(value: 52),
                  ),
                ],
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppString.instance.feelFree,
                color: AppColors.instance.grey800,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              Gap(
                height: 10,
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
                      itemSize: 35,
                      initialRating: controller.currentRating.value,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: AppColors.instance.ratingBar,
                      ),
                      onRatingUpdate: (rating) {
                        controller.currentRating.value = rating;
                        log(rating.toString());
                      },
                    ),
                    Gap(
                      height: 10,
                    ),
                    AppInputReview(
                      hintText: "Write a review here...",
                      fillColor: AppColors.instance.white50,
                      borderColor: AppColors.instance.grey300,
                      controller: controller.review.value,
                      maxLines: 5,
                    ),
                    Gap(
                      height: 20,
                    ),
                    AppButton(
                      backgroundColor: controller.isLoading.value
                          ? AppColors.instance.grey300
                          : AppColors.instance.green500,
                      titleColor: AppColors.instance.white50,
                      title: controller.isLoading.value
                          ? "Submitting..."
                          : AppString.instance.submit,
                      onTap: controller.isLoading.value
                          ? null
                          : () {
                              controller.submitReview();
                            },
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
        );
      }),
    );
  }
}
