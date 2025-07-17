import 'package:ahmed_shop/services/repository/payment_repository/payment_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';

import '../../../../../services/repository/payment_repository/payment_connected_screen.dart';

class OwnerMenuPaymentMethodController extends GetxController {
  RxBool isLoading = false.obs;

  /// Connect to Stripe payment gateway
  Future<void> connectStripePayment() async {
    try {
      isLoading.value = true;

      // Call the connectWallet method from repository
      bool? result = await PaymentRepository.connectWallet();

      if (result == true) {
        // Get the payment URL from the repository
        String? paymentUrl = await _getPaymentUrl();

        if (paymentUrl != null && paymentUrl.isNotEmpty) {
          // Navigate to payment connection screen
          Get.to(() => PaymentConnectedScreen(paymentUrl: paymentUrl));
        } else {
          AppSnackBar.error('Failed to get payment URL');
        }
      } else {
        AppSnackBar.error('Failed to connect payment gateway');
      }
    } catch (e) {
      AppSnackBar.error('Error connecting payment gateway: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  /// Get payment URL from repository
  Future<String?> _getPaymentUrl() async {
    try {
      // We need to modify the PaymentRepository to return the URL
      // For now, we'll call connectWallet and get the URL
      var result = await PaymentRepository.connectWalletWithUrl();
      return result;
    } catch (e) {
      return null;
    }
  }
}
