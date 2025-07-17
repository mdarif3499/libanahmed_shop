import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button_row.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controller/owner_menu_payment_method_contrller.dart';

class OwnerMenuPaymentOption extends StatelessWidget {
  const OwnerMenuPaymentOption({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller
    final controller = Get.put(OwnerMenuPaymentMethodController());

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.paymentMethod,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(height: AppSize.height(value: 12)),
            Center(
              child: Image.asset(
                AppAssertImage.instance.payment,
                height: AppSize.height(value: 185),
                width: AppSize.width(value: 170),
                color: AppColors.instance.red500,
              ),
            ),
            Gap(height: AppSize.height(value: 22)),
            AppText(
              text: "Please Add Your Payment Gateway for Transections",
              fontFamily: 2,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.instance.black600,
              maxLines: 2,
            ),
            Gap(height: AppSize.height(value: 15)),
            AppText(
              text:
                  'Continue to add Your Payment Gateway for Transections. Click on the button below to add your payment gateway. After adding your payment gateway you can start accepting payments. Enjoy your business.',
              fontFamily: 2,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black700,
              maxLines: 6,
              textAlign: TextAlign.justify,
            ),
            Gap(height: AppSize.height(value: 20)),
            Obx(
              () => AppImageButton(
                imagePosition: ImagePosition.right,
                image: controller.isLoading.value
                    ? SizedBox(
                        height: AppSize.height(value: 24),
                        width: AppSize.width(value: 24),
                        child: CircularProgressIndicator(
                          color: AppColors.instance.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Image.asset(
                        AppAssertImage.instance.stripe,
                        height: AppSize.height(value: 24),
                        width: AppSize.width(value: 48),
                      ),
                title: controller.isLoading.value
                    ? "Connecting..."
                    : "Continue with ",
                fontSize: 16,
                titleColor: AppColors.instance.white,
                backgroundColor: AppColors.instance.red500,
                onTap: controller.isLoading.value
                    ? null
                    : () => controller.connectStripePayment(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
