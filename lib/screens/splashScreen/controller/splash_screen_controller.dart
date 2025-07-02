import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class UserSplashController extends GetxController {
  final StorageServices storageServices = StorageServices.instance;

  // To handle navigation after a delay
  void navigateBasedOnUserRole() async {
    await Future.delayed(Duration(seconds: 3)); // Splash delay

    // Check if the user is logged in
    String token = storageServices.getToken();
    if (token.isNotEmpty) {
      // Get the user role
      String? role = storageServices.getUserRole();

      if (role == "customer") {
        Get.offAllNamed(
            AppRoutes.userNavigationScreen);
        appLog(
            "🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑\n $token \n 🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑");
      } else if (role == "seller") {
        Get.offAllNamed(
            AppRoutes.ownerBottomNav); // Navigate to owner bottom nav
        appLog(
            "🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑\n $token \n 🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑");
      } else {
        Get.offAllNamed(
            AppRoutes.onboardScreen); // Navigate to onboarding screen
        appLog(
            "🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑\n $token \n 🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑🛑");
      }
    } else {
      Get.offAllNamed(AppRoutes.onboardScreen); // Navigate to onboarding screen
    }
  }

  @override
  void onInit() {
    super.onInit();
    navigateBasedOnUserRole();
  }
}
