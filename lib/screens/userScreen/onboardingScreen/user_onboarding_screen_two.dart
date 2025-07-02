import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/onboardingScreen/owner_onboarding_screen.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_assert_image.dart';

class UserOnboardingScreenTwo extends StatefulWidget {
  const UserOnboardingScreenTwo({super.key});

  @override
  State<UserOnboardingScreenTwo> createState() =>
      _UserOnboardingScreenTwoState();
}

class _UserOnboardingScreenTwoState extends State<UserOnboardingScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          AppAssertImage.instance.onboard2,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(top: 35, bottom: 40, left: 20, right: 20),
            decoration: BoxDecoration(
              color: AppColors.instance.white100.withAlpha(230),
            ),
            child: Column(
              children: [
                Center(
                  child: AppText(
                    text: AppString.instance.chooseRole,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 1,
                  ),
                ),
                Gap(
                  height: 20,
                ),
                AppText(
                  text: AppString.instance.beforeContinuing,
                  fontFamily: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  maxLines: 2,
                ),
                Gap(
                  height: 23,
                ),
                // Join as the Customer Button
                IconAppButton(
                  icon: AppAssertIcons.forwardIcon,
                  backgroundColor: AppColors.instance.green500,
                  onTap: () {
                    Get.toNamed(AppRoutes.createAccount);
                  },
                  title: AppString.instance.joinAsCustomer,
                  titleColor: AppColors.instance.white100,
                  borderRadius: 16,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  iconAlignment: CustomIconAlignment.right,
                  fontSize: 16,
                  rowWidth: 200.0,
                ),
                Gap(
                  height: 12,
                ),
                IconAppButton(
                  icon: AppAssertIcons.forwardIcon,
                  backgroundColor: AppColors.instance.red500,
                  onTap: () {
                    Get.offAll(() => OwnerOnboardingScreen());
                  },
                  title: AppString.instance.joinAsOwner,
                  titleColor: AppColors.instance.white100,
                  borderRadius: 16,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  iconAlignment: CustomIconAlignment.right,
                  fontSize: 16,
                  rowWidth: 200.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
