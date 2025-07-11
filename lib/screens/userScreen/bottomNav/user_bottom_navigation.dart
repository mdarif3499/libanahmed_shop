import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/controller/navigation_controller.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/user_cart_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/user_home_screen.dart';
import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/user_product_details_screen.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/user_profile_screen.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/user_search_screen.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuDrawer/user_menu_screen.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constant/app_assert_image.dart';

class UserNavigationScreen extends StatelessWidget {
  const UserNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Move the GlobalKey outside of GetBuilder to prevent recreation
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return GetBuilder(
        init: NavigationController(),
        builder: (controller) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: AppColors.instance.white50,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssertImage.instance.logoIcon, height: 40,width: 40,)
                ],
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: SvgPicture.asset(AppAssertIcons.userMenu),
              ),
              actions: [
                IconButton(
                  onPressed: () {}, // Add functionality for notifications
                  icon: SvgPicture.asset(AppAssertIcons.userNotification),
                ),
              ],
            ),
            drawer: const UserMenuDrawer(),
            body: Obx(
              () => IndexedStack(
                index: controller.selectedIndex.value,
                children: [
                  ////////// index 0
                  UserHomeScreen(),
                  ////////// index 1
                  UserSearchScreen(),
                  /////////// index 2
                  const UserCartScreen(),
                  /////////// index 3
                  UserProfileScreen(),
                  UserProductDetailsScreen()
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: ClipOval(
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.instance.green500.withAlpha(80),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Material(
                  color: AppColors.instance.green500,
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    onTap: () {
                      controller.changeIndex(4);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: AppSize.width(value: 50),
                      height: AppSize.height(value: 50),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAssertIcons.uProduct,
                        height: AppSize.width(value: 22),
                        width: AppSize.height(value: 22),
                        colorFilter: ColorFilter.mode(
                          AppColors.instance.white50,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: AppSize.height(value: 70),
              padding: EdgeInsets.symmetric(vertical: AppSize.width(value: 8)),
              decoration: BoxDecoration(color: AppColors.instance.white),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //////////////////  home
                    GestureDetector(
                      onTap: () {
                        controller.changeIndex(0);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            controller.selectedIndex.value == 0
                                ? AppAssertIcons.uHomeSelected
                                : AppAssertIcons.uHome,
                            width: AppSize.width(value: 25),
                            height: AppSize.height(value: 25),
                          ),
                          AppText(
                            text: AppString.instance.home,
                            color: controller.selectedIndex.value == 0
                                ? AppColors.instance.green500
                                : AppColors.instance.bottomNavText,
                          )
                        ],
                      ),
                    ),

                    ////////////  Search
                    GestureDetector(
                      onTap: () {
                        controller.changeIndex(1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            controller.selectedIndex.value == 1
                                ? AppAssertIcons.uSearchSelected
                                : AppAssertIcons.uSearch,
                            width: AppSize.width(value: 25),
                            height: AppSize.height(value: 25),
                          ),
                          AppText(
                            text: AppString.instance.search,
                            color: controller.selectedIndex.value == 1
                                ? AppColors.instance.green500
                                : AppColors.instance.bottomNavText,
                          )
                        ],
                      ),
                    ),
                    const Gap(width: 30),

                    /////////////  cart
                    GestureDetector(
                      onTap: () {
                        controller.changeIndex(2);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            controller.selectedIndex.value == 2
                                ? AppAssertIcons.uCartSelected
                                : AppAssertIcons.uCart,
                            width: AppSize.width(value: 25),
                            height: AppSize.height(value: 25),
                          ),
                          AppText(
                            text: AppString.instance.cart,
                            color: controller.selectedIndex.value == 2
                                ? AppColors.instance.green500
                                : AppColors.instance.bottomNavText,
                          )
                        ],
                      ),
                    ),
                    //////////// account
                    GestureDetector(
                      onTap: () {
                        controller.changeIndex(3);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            controller.selectedIndex.value == 3
                                ? AppAssertIcons.uProfileSelected
                                : AppAssertIcons.uProfile,
                            width: AppSize.width(value: 25),
                            height: AppSize.height(value: 25),
                          ),
                          AppText(
                            text: AppString.instance.userProfile,
                            color: controller.selectedIndex.value == 3
                                ? AppColors.instance.green500
                                : AppColors.instance.bottomNavText,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
