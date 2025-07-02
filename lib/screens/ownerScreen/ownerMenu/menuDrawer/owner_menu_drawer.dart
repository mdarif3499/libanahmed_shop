import 'dart:ui';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerMenuDrawer extends StatefulWidget {
  const OwnerMenuDrawer({super.key});

  @override
  State<OwnerMenuDrawer> createState() => _OwnerMenuDrawerState();
}

class _OwnerMenuDrawerState extends State<OwnerMenuDrawer> {
  List<String> buttonTitle = [
    AppString.instance.bestSellingItems,
    AppString.instance.cancelledOrders,
    AppString.instance.transactions,
    AppString.instance.offers,
    AppString.instance.ratings,
    AppString.instance.paymentMethod,
    AppString.instance.shopCreation
  ];
  List<String> buttonIcon = [
    AppAssertIcons.menuBestSelling,
    AppAssertIcons.menuCancelOrder,
    AppAssertIcons.menuTransaction,
    AppAssertIcons.menuOffers,
    AppAssertIcons.menuRating,
    AppAssertIcons.menuPaymentMethod,
    AppAssertIcons.oShop,
  ];
  List<String> pages = [
    AppRoutes.ownerMenuBestSelling,
    AppRoutes.ownerMenuCancelOrder,
    AppRoutes.ownerMenuTransaction,
    AppRoutes.ownerMenuOffers,
    AppRoutes.ownerMenuRating,
    AppRoutes.ownerMenuPaymentMethod,
    AppRoutes.ownerStoreVerification,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(left: 22, top: 48, right: 46),
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: AppColors.instance.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppButton(
                    title: "Ahmed-LOGO",
                    titleColor: AppColors.instance.white,
                    backgroundColor: AppColors.instance.red500,
                    height: AppSize.height(value: 64),
                  ),
                  Gap(
                    height: 28,
                  ),
                  ...List.generate(pages.length, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(pages[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.instance.red50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(buttonIcon[index]),
                                Gap(
                                  width: 8,
                                ),
                                AppText(
                                  text: buttonTitle[index],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.textColor,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                    AppAssertIcons.userProfileForward)
                              ],
                            ),
                          ),
                        ),
                        Gap(
                          height: 15,
                        )
                      ],
                    );
                  }),
                  Gap(
                    height: AppSize.height(value: 150),
                  ),
                  IconAppButton(
                    iconAlignment: CustomIconAlignment.left,
                    fontSize: 16,
                    icon: AppAssertIcons.menuLogout,
                    iconSize: 20,
                    title: AppString.instance.signOut,
                    onTap: () async {
                      try {
                        // Clear all stored user data
                        await StorageServices.instance.storageClear();

                        // Navigate to the onboarding screen
                        Get.offAllNamed(AppRoutes.onboardScreenTwo);

                        // Show success message
                        AppSnackBar.success("Logged out successfully.");
                      } catch (e) {
                        // Log the error and show an error message
                        errorLog("Logout Error", e);
                        AppSnackBar.error(
                            "Failed to log out. Please try again.");
                      }
                    },
                    titleColor: AppColors.instance.textColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    backgroundColor: AppColors.instance.black50,
                    borderRadius: 8,
                    height: AppSize.height(value: 56),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
