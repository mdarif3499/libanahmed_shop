import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerOrderProgress extends StatelessWidget {
  const OwnerOrderProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.trackOrder,
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
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.instance.red50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    AppAssertIcons.trackOrderIcon,
                    height: AppSize.height(value: 25),
                    width: AppSize.width(
                      value: 25,
                    ),
                  ),
                  Gap(width: 13),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppString.instance.orderNumber,
                        fontFamily: 2,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.instance.textColor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(height: 2),
                      AppText(
                        text: AppString.instance.southDakota,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.instance.black300,
                      ),
                      Gap(height: 2),
                      AppText(
                        text: AppString.instance.items,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.instance.black300,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      AppAssertIcons.trackOrderCross,
                      height: AppSize.height(value: 35),
                      width: AppSize.width(value: 35),
                    ),
                  ),
                ],
              ),
            ),
            Gap(
              height: 15,
            ),
            // Vertical Easy Stepper
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.instance.red500,
                      ),
                      child: SvgPicture.asset(AppAssertIcons.stepper1),
                    ),
                    Gap(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppString.instance.orderPlaced,
                          fontFamily: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(
                          height: 5,
                        ),
                        AppText(
                          text: AppString.instance.orderDate,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 1,
                          color: AppColors.instance.black300,
                        ),
                      ],
                    )
                  ],
                ),
                Gap(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.instance.red500,
                      ),
                      child: SvgPicture.asset(AppAssertIcons.stepper2),
                    ),
                    Gap(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppString.instance.orderPlaced,
                          fontFamily: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(
                          height: 5,
                        ),
                        AppText(
                          text: AppString.instance.orderDate,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 1,
                          color: AppColors.instance.black300,
                        ),
                      ],
                    )
                  ],
                ),
                Gap(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.instance.red500,
                      ),
                      child: SvgPicture.asset(AppAssertIcons.stepper3),
                    ),
                    Gap(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppString.instance.orderPlaced,
                          fontFamily: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(
                          height: 5,
                        ),
                        AppText(
                          text: AppString.instance.orderDate,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 1,
                          color: AppColors.instance.black300,
                        ),
                      ],
                    )
                  ],
                ),
                Gap(
                  height: 25,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.instance.red500,
                      ),
                      child: SvgPicture.asset(AppAssertIcons.stepper4),
                    ),
                    Gap(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: AppString.instance.orderPlaced,
                          fontFamily: 1,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(
                          height: 5,
                        ),
                        AppText(
                          text: AppString.instance.orderDate,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 1,
                          color: AppColors.instance.black300,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

            Gap(
              height: 20,
            ),
            AppButton(
              title: AppString.instance.viewOrder,
              titleColor: AppColors.instance.textColor,
              backgroundColor: AppColors.instance.white,
              borderColor: AppColors.instance.textColor,
              onTap: () {
                Get.toNamed(AppRoutes.viewOrder);
              },
            ),
            Gap(
              height: 20,
            ),
            AppButton(
              title: AppString.instance.giveRatings,
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.red500,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
