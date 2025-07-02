import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/customer_auth_repository/auth_repository.dart';
import '../../../../../utils/error_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class UserOtpVerificationController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  late String forgetToken;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the forgetToken from arguments
    forgetToken = Get.arguments["forgetToken"];
  }

  Future<void> verifyOtp(String otp) async {
    try {
      // Use the forgetToken in the API call
      var response = await authRepository.verifyForgotPasswordOtp(
        otp: otp,
        token: forgetToken,
      );

      if (response != null && response["success"] == true) {
        AppSnackBar.success("OTP verified successfully!");
        Get.toNamed(AppRoutes.resetPassword);
      } else {
        AppSnackBar.error(response?["message"] ?? "OTP verification failed.");
      }
    } catch (e) {
      // Log the error and show a generic error message
      errorLog("verifyOtp controller function", e);
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }
}
