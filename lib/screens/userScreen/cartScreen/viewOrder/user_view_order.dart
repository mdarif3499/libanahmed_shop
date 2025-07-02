import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserViewOrder extends StatelessWidget {
  const UserViewOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.viewOrder,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppSize.width(value: double.maxFinite),
              decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  border:
                      Border.all(color: AppColors.instance.authBorderColor)),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: AppString.instance.orderDetails,
                    fontWeight: FontWeight.w500,
                    fontFamily: 1,
                    fontSize: 18,
                    color: AppColors.instance.textColor,
                  ),
                  Gap(height: 8),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderName}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                  Gap(height: 5),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderContact}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                  Gap(height: 5),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderAddress}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                  Gap(height: 5),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderNo}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                  Gap(height: 5),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderPlacedDate}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                  Gap(height: 5),
                  AppText(
                    text:
                        "${AppString.instance.bullet}${AppString.instance.orderDeliveryTime}",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.greyTextColor,
                  ),
                ],
              ),
            ),
            Gap(height: 30),

            ///// Order Details
            Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.instance.grey200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: AppText(
                      text: "Item Name",
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.instance.greyTextColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AppText(
                      text: "Quantity",
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.instance.greyTextColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AppText(
                      text: "Price",
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      color: AppColors.instance.greyTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                ),
                child: Column(
                  children: List.generate(8, (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: AppText(
                                text: "Red Watermelon",
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.instance.greyTextColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppText(
                                text: "2 Kg",
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.instance.greyTextColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: AppText(
                                text: "\$32.50",
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: AppColors.instance.greyTextColor,
                              ),
                            ),
                          ],
                        ),
                        Gap(
                          height: 10,
                        )
                      ],
                    );
                  }),
                )),
            Gap(height: 10),
          ],
        ),
      ),
    );
  }
}
