import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.instance.grey100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.instance.grey300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppString.instance.gilbert,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: AppColors.instance.textColor,
                      ),
                      Gap(
                        height: 2,
                      ),
                      AppText(
                        text: AppString.instance.gilbertEmail,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.greyColor,
                      ),
                      Gap(
                        height: 2,
                      ),
                      AppText(
                        text: AppString.instance.gilbertPhone,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.greyColor,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.editProfile);
                    },
                    child: AppText(
                      text: AppString.instance.edit,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: AppColors.instance.red500,
                    ),
                  )
                ],
              ),
            ),
            Gap(
              height: 12,
            ),
            IconAppButton(
              iconAlignment: CustomIconAlignment.right,
              fontSize: 16,
              icon: AppAssertIcons.userProfileForward,
              iconSize: 20,
              title: AppString.instance.aboutUs,
              onTap: () {
                Get.toNamed(AppRoutes.ownerAboutUs);
              },
              titleColor: AppColors.instance.black400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            Gap(
              height: 12,
            ),
            IconAppButton(
              iconAlignment: CustomIconAlignment.right,
              fontSize: 16,
              icon: AppAssertIcons.userProfileForward,
              iconSize: 20,
              title: AppString.instance.faqs,
              onTap: () {
                Get.toNamed(AppRoutes.ownerFaq);
              },
              titleColor: AppColors.instance.black400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            Gap(
              height: 12,
            ),
            IconAppButton(
              iconAlignment: CustomIconAlignment.right,
              fontSize: 16,
              icon: AppAssertIcons.userProfileForward,
              iconSize: 20,
              title: AppString.instance.privacyPolicy,
              onTap: () {
                Get.toNamed(AppRoutes.ownerPrivacyPolicy);
              },
              titleColor: AppColors.instance.black400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            Gap(
              height: 12,
            ),
            IconAppButton(
              iconAlignment: CustomIconAlignment.right,
              fontSize: 16,
              icon: AppAssertIcons.userProfileForward,
              iconSize: 20,
              title: AppString.instance.termsAndConditions,
              onTap: () {
                Get.toNamed(AppRoutes.ownerTermsAndConditions);
              },
              titleColor: AppColors.instance.black400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            Gap(
              height: 12,
            ),
            IconAppButton(
              iconAlignment: CustomIconAlignment.right,
              fontSize: 16,
              icon: AppAssertIcons.userProfileForward,
              iconSize: 20,
              title: AppString.instance.contactSupport,
              onTap: () {
                Get.toNamed(AppRoutes.ownerContactSupport);
              },
              titleColor: AppColors.instance.black400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
          ],
        ),
      ),
    );
  }
}
