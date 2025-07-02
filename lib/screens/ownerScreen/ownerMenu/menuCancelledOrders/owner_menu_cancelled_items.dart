import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerMenuCancelledItems extends StatelessWidget {
  const OwnerMenuCancelledItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.cancelledOrders,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back(); // Navigate back when back button is pressed
          },
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: List.generate(8, (index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.instance.red50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          AppAssertIcons.trackOrderIcon,
                          height: AppSize.height(value: 25),
                          width: AppSize.width(value: 25),
                        ),
                        SizedBox(width: 13),
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
                            SizedBox(height: 2),
                            AppText(
                              text: AppString.instance.southDakota,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.instance.black300,
                            ),
                            SizedBox(height: 2),
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
                        Align(
                          alignment: Alignment.topRight,
                          child: AppButton(
                            title: AppString.instance.cancel,
                            backgroundColor: AppColors.instance.red500,
                            titleColor: AppColors.instance.white,
                            height: AppSize.height(value: 24),
                            width: AppSize.width(value: 60),
                            onTap: () {
                              // Handle cancel functionality
                              print("Cancel clicked for order $index");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              );
            }),
          )),
    );
  }
}
