import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/repository/payment_repository/payment_screen.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentRepository {
  //! User Payment Repository
  static Future<bool?> userPayment({
    required String orderId,
    required int shippingCost,
  }) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.createPayment,
        body: {"orderId": orderId, "shippingCost": shippingCost},
        header: {"Authorization": token},
      );

      if (response != null && response["data"] != null) {
        String paymentUrl = response["data"]["url"];
        appLog("Payment URL: $paymentUrl");

        // Option 1: Use url_launcher (recommended)
        //await _launchPaymentUrl(paymentUrl);

        // Option 2: Use custom payment screen
        Get.to(() => PaymentScreen(url: paymentUrl, orderId: orderId));

        return true;
      }
      return false;
    } catch (e) {
      errorLog("userPayment", e);
      return false;
    }
  }

  static Future<bool?> connectWallet() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerConnectedPayment,
        header: {"Authorization": token},
      );
      if (response != null && response["data"] != null) {
        String paymentUrl = response["data"]["url"];
        appLog("Payment URL: $paymentUrl");

        return true;
      }
      return false;
    } catch (e) {
      errorLog("connectWallet", e);
      return false;
    }
  }

  //! New method to get payment URL for wallet connection
  static Future<String?> connectWalletWithUrl() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerConnectedPayment,
        header: {"Authorization": token},
      );

      if (response != null && response["data"] != null) {
        String paymentUrl = response["data"]["url"];
        appLog("Payment URL: $paymentUrl");
        return paymentUrl;
      }
      return null;
    } catch (e) {
      errorLog("connectWalletWithUrl", e);
      return null;
    }
  }

  //! Save account ID after successful connection
  static Future<bool> saveAccountId(String accountId) async {
    try {
      // Save account ID to local storage or send to server
      StorageServices.instance.saveData("stripe_account_id", accountId);
      appLog("Account ID saved: $accountId");
      return true;
    } catch (e) {
      errorLog("saveAccountId", e);
      return false;
    }
  }

  //! Get saved account ID
  static String? getAccountId() {
    try {
      return StorageServices.instance.getData("stripe_account_id");
    } catch (e) {
      errorLog("getAccountId", e);
      return null;
    }
  }

}
