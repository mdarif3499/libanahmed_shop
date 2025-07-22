import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/controller/profile_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller if not already done
    final OwnerProfileController controller = Get.put(OwnerProfileController());

    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Obx(() {
              // Check if loading or data is available
              if (controller.isLoading.value) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: AppColors.instance.red400,
                    size: AppSize.height(value: 40),
                  ),
                );
              }
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.instance.grey100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.instance.grey300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            // Display fullName from profileData or fallback
                            text:
                                controller.profileData.value?.data?.fullName ??
                                AppString.instance.gilbert,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.instance.textColor,
                          ),
                          const Gap(height: 2),
                          AppText(
                            // Display email from profileData or fallback
                            text:
                                controller.profileData.value?.data?.email ??
                                AppString.instance.gilbertEmail,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.greyColor,
                          ),
                          const Gap(height: 2),
                          AppText(
                            // Display phone from profileData or fallback
                            text:
                                controller.profileData.value?.data?.phone ??
                                AppString.instance.gilbertPhone,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.greyColor,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.ownerEditProfile);
                      },
                      child: AppText(
                        text: AppString.instance.edit,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.instance.red500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Gap(height: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            const Gap(height: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            const Gap(height: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            const Gap(height: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              backgroundColor: AppColors.instance.white300,
              borderRadius: 8,
              rowWidth: 10,
              height: AppSize.height(value: 56),
            ),
            const Gap(height: 12),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
