import 'package:ahmed_shop/screens/ownerScreen/analyticScreen/owner_analytic_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/owner_home_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/owner_order_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/controller/profile_binding.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/owner_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerBottomNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Function to handle item taps
  void onItemTapped(int index) {
    // Initialize the binding when profile tab is selected
    if (index == 3) { // Assuming profile is the 4th tab (0-based index 3)
      ProfileBinding().dependencies();
    }
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
