import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if there are arguments passed
    if (Get.arguments != null && Get.arguments['initialIndex'] != null) {
      selectedIndex.value = Get.arguments['initialIndex'];
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  static void navigateToHome() {
    try {
      // Try to find existing controller and update it
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(0);
    } catch (e) {
      // If controller not found, navigate to the screen with home index
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 0},
      );
    }
  }

  // Add this method for search navigation
  static void navigateToSearch() {
    try {
      // Try to find existing controller and update it
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(1);
    } catch (e) {
      // If controller not found, navigate to the screen with search index
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 1},
      );
    }
  }

  // Add this method for cart navigation
  static void navigateToCart() {
    try {
      // Try to find existing controller and update it
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(2);
    } catch (e) {
      // If controller not found, navigate to the screen with cart index
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 2},
      );
    }
  }

  // Add this method for profile navigation
  static void navigateToProfile() {
    try {
      // Try to find existing controller and update it
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(3);
    } catch (e) {
      // If controller not found, navigate to the screen with profile index
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 3},
      );
    }
  }
  // Add this method for home navigation
}
