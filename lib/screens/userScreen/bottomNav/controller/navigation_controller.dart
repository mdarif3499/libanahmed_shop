import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var productDetailsArguments = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['initialIndex'] != null) {
        selectedIndex.value = Get.arguments['initialIndex'];
      }
      if (Get.arguments['productId'] != null) {
        productDetailsArguments.value = {'id': Get.arguments['productId']};
      }
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    
    // Clear product details arguments when navigating away from product details
    if (index != 4) {
      productDetailsArguments.clear();
    }
  }

  static void navigateToHome() {
    try {
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(0);
    } catch (e) {
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 0},
      );
    }
  }

  static void navigateToSearch() {
    try {
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(1);
    } catch (e) {
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 1},
      );
    }
  }

  static void navigateToCart() {
    try {
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(2);
    } catch (e) {
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 2},
      );
    }
  }

  static void navigateToProfile() {
    try {
      NavigationController controller = Get.find<NavigationController>();
      controller.changeIndex(3);
    } catch (e) {
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 3},
      );
    }
  }

  static void navigateToProductDetails(String productId) {
    try {
      NavigationController controller = Get.find<NavigationController>();
      controller.productDetailsArguments.value = {'id': productId};
      controller.changeIndex(4);
    } catch (e) {
      Get.offNamed(
        AppRoutes.userNavigationScreen,
        arguments: {'initialIndex': 4, 'productId': productId},
      );
    }
  }
}