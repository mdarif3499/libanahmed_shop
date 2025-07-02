import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/controller/user_bottom_nav_controller.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuDrawer/user_menu_screen.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserBottomNav extends StatelessWidget {
  // Create a GlobalKey for Scaffold to access the ScaffoldState
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  UserBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBottomNavController controller =
        Get.put(UserBottomNavController());

    // Get the index from arguments, default to 0 if not provided
    int initialIndex = Get.arguments ?? 0;
    controller.selectedIndex.value = initialIndex;

    return Scaffold(
      key: scaffoldKey,
      // Assign the key to the Scaffold
      appBar: _buildAppBar(context),
      // Pass context to _buildAppBar
      body: Obx(() {
        return controller.pages[controller.selectedIndex.value];
      }),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.instance.white50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(
              context,
              AppAssertIcons.uHome, // Default icon
              AppAssertIcons.uHomeSelected, // Selected icon
              'Home',
              0,
              controller,
            ),
            buildNavBarItem(
              context,
              AppAssertIcons.uSearch,
              AppAssertIcons.uSearchSelected,
              'Search',
              1,
              controller,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.06,
            ),
            buildNavBarItem(
              context,
              AppAssertIcons.uCart,
              AppAssertIcons.uCartSelected,
              'Cart',
              2,
              controller,
            ),
            buildNavBarItem(
              context,
              AppAssertIcons.uProfile,
              AppAssertIcons.uProfileSelected,
              'Profile',
              3,
              controller,
            ),
          ],
        ),
      ),
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
                // Simply navigate to the Product Details screen without hiding bottom nav
                controller.navigateToProductDetails();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: AppSize.width(value: 50),
                height: AppSize.height(value: 50),
                alignment: Alignment.center, // Center the icon
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const UserMenuDrawer(), // Add the drawer here
    );
  }

  // Custom AppBar widget
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.instance.white50,
      title: AppText(
        text: AppString.instance.ahmed,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.instance.black400,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          // Use the scaffoldKey to open the drawer
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
    );
  }

  // Method to build individual navbar items
  Widget buildNavBarItem(
      BuildContext context,
      String iconPath,
      String selectedIconPath,
      String label,
      int index,
      UserBottomNavController controller) {
    return Obx(() {
      // Determine which icon to show based on whether the tab is selected
      String iconToShow =
          controller.selectedIndex.value == index ? selectedIconPath : iconPath;

      return InkWell(
        onTap: () => controller.onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconToShow, // Switch between selected and default icon
              width: AppSize.width(value: 25),
              height: AppSize.height(value: 25),
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.selectedIndex.value == index
                    ? AppColors.instance.green500
                    : AppColors.instance.bottomNavText,
              ),
            ),
          ],
        ),
      );
    });
  }
}
