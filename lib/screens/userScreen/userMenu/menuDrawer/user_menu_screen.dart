import 'dart:ui';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../services/storage_services/storage_services.dart';
import '../../../../utils/error_log.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserMenuDrawer extends StatefulWidget {
  const UserMenuDrawer({super.key});

  @override
  State<UserMenuDrawer> createState() => _UserMenuDrawerState();
}

class _UserMenuDrawerState extends State<UserMenuDrawer> {
  List<String> buttonTitle = [
    AppString.instance.myFavorites,
    AppString.instance.offers,
    AppString.instance.myOrder,
    AppString.instance.customerService,

    //AppString.instance.ratings,
  ];
  List<String> buttonIcon = [
    AppAssertIcons.menuFavorite,
    AppAssertIcons.menuOffers,
    AppAssertIcons.trackOrderIcon,
    AppAssertIcons.menuCusSer,

    //AppAssertIcons.menuRating,
  ];
  List<String> pages = [
    AppRoutes.menuFavorites,
    AppRoutes.menuOffers,
    AppRoutes.userTrackOrder,
    AppRoutes.menuCusSer,

    //AppRoutes.menuRating,
  ];

  void showSignourDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: 300, // You can use AppSize if it's defined
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white, // Use AppColors.white100 if defined
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(height: AppSize.height(value: 20)),
                  Text(
                    'Are you sure you want to Sign out?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppButton(
                        height: AppSize.height(value: 48),
                        width: AppSize.width(value: 60),
                        title: "No",
                        titleColor: AppColors.instance.white100,
                        backgroundColor: AppColors.instance.green500,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      AppButton(
                        height: AppSize.height(value: 48),
                        width: AppSize.width(value: 60),
                        title: "Yes",
                        titleColor: AppColors.instance.white100,
                        backgroundColor: AppColors.instance.red500,
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
                              "Failed to log out. Please try again.",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  Gap(height: AppSize.height(value: 20)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Drawer(
          child: Container(
            padding: EdgeInsets.only(left: 22, top: 48, right: 46),
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(color: AppColors.instance.white),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppAssertImage.instance.logoIcon,
                    height: 60,
                    width: 60,
                  ),
                  Gap(height: 28),
                  ...List.generate(pages.length, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(pages[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.instance.green50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(buttonIcon[index]),
                                Gap(width: 8),
                                AppText(
                                  text: buttonTitle[index],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.textColor,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  AppAssertIcons.userProfileForward,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(height: 15),
                      ],
                    );
                  }),
                  Gap(height: 200),
                  IconAppButton(
                    iconAlignment: CustomIconAlignment.left,
                    fontSize: 16,
                    icon: AppAssertIcons.menuLogout,
                    iconSize: 20,
                    title: AppString.instance.logOut,
                    onTap: () {
                      showSignourDialog(context);
                      // try {
                      //   // Clear all stored user data
                      //   await StorageServices.instance.storageClear();

                      //   // Navigate to the onboarding screen
                      //   Get.offAllNamed(AppRoutes.onboardScreenTwo);

                      //   // Show success message
                      //   AppSnackBar.success("Logged out successfully.");
                      // } catch (e) {
                      //   // Log the error and show an error message
                      //   errorLog("Logout Error", e);
                      //   AppSnackBar.error(
                      //     "Failed to log out. Please try again.",
                      //   );
                      // }
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
