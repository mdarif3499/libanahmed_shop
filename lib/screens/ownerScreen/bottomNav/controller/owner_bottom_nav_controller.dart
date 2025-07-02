import 'package:ahmed_shop/screens/ownerScreen/analyticScreen/owner_analytic_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/owner_home_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/owner_order_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/owner_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerBottomNavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    OwnerMyShop(),
    OwnerOrderScreen(),
    OwnerAnalyticScreen(),
    OwnerProfileScreen(),
  ];

  // Function to handle item taps
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
