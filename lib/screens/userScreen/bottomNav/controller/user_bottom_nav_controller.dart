import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/user_cart_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/user_home_screen.dart';
import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/user_product_details_screen.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/user_profile_screen.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/user_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserBottomNavController extends GetxController {
  var selectedIndex = 0.obs; // Observable variable for selected index

  final List<Widget> pages = [
    UserHomeScreen(), // Home screen
    UserSearchScreen(), // Search screen
    UserCartScreen(), // Cart screen
    UserProfileScreen(), // Profile screen
  ];

  // Method to update selected index
  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  // Method to navigate to a specific tab
  void navigateToTab(int index) {
    selectedIndex.value = index;
  }

  // Method to navigate to the product details screen
  void navigateToProductDetails() {
    Get.to(() => UserProductDetailsScreen());
  }
}
