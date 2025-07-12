import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/screens/ownerScreen/bottomNav/controller/owner_bottom_nav_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../analyticScreen/owner_analytic_screen.dart';
import '../myShopScreen/mainMyShop/owner_home_screen.dart';
import '../orderScreen/orderMain/owner_order_screen.dart';
import '../ownerMenu/menuDrawer/owner_menu_drawer.dart';
import '../profileScreen/profileHome/owner_profile_screen.dart';
// Import the OwnerMenuDrawer widget

class OwnerBottomNav extends StatelessWidget {
  // Create a GlobalKey for Scaffold to access the ScaffoldState
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  OwnerBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerBottomNavController controller = Get.put(
      OwnerBottomNavController(),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: _buildAppBar(context),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          OwnerMyShop(),
          OwnerOrderScreen(),
          OwnerAnalyticScreen(),
          OwnerProfileScreen(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(controller),
      drawer: const OwnerMenuDrawer(),
    );
  }

  // Custom AppBar widget
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.instance.white50,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssertImage.instance.logoIcon, height: 40, width: 40),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          // Use the Scaffold key to open the drawer
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

  // Custom BottomNavigationBar widget
  Widget _buildBottomNavBar(OwnerBottomNavController controller) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.onItemTapped,
        backgroundColor: AppColors.instance.white50,
        selectedItemColor: AppColors.instance.red500,
        unselectedItemColor: AppColors.instance.bottomNavText,
        type: BottomNavigationBarType.fixed,
        items: _buildNavBarItems(controller),
      ),
    );
  }

  // Method to create BottomNavigationBarItems
  List<BottomNavigationBarItem> _buildNavBarItems(
    OwnerBottomNavController controller,
  ) {
    final List<String> labels = ['Shop', 'Orders', 'Analytics', 'Profile'];
    final List<String> iconPaths = [
      controller.selectedIndex.value == 0
          ? AppAssertIcons.oShopFill
          : AppAssertIcons.oShop,
      controller.selectedIndex.value == 1
          ? AppAssertIcons.oOrderFill
          : AppAssertIcons.oOrder,
      controller.selectedIndex.value == 2
          ? AppAssertIcons.oAnalyticFill
          : AppAssertIcons.oAnalytic,
      controller.selectedIndex.value == 3
          ? AppAssertIcons.oProfileFill
          : AppAssertIcons.oProfile,
    ];

    return List.generate(4, (index) {
      return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          iconPaths[index],
          width: AppSize.width(value: 25),
          height: AppSize.height(value: 25),
        ),
        label: labels[index],
      );
    });
  }
}
