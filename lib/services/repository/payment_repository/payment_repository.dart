import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/repository/payment_repository/payment_screen.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

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

  static Future<void> _launchPaymentUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
