import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/analyticScreen/models/analytics_screen_models.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';

import '../../../screens/ownerScreen/analyticScreen/models/analytics_screen_models_ratio.dart';
import '../../storage_services/storage_services.dart';

class OwnerAnalyticsRepository {
  static Future<SellerOverViewModel?> getSellerOverview() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.ownerOverView,
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return SellerOverViewModel.fromJson(response);
      } else {
        appLog("Failed to load products: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      appLog('Error fetching products: $e');
      return null;
    }
  }

  static Future<SellerIncomeRatioModel?> getSellerIncomeRatio() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.ownerIncomeRatio,
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return SellerIncomeRatioModel.fromJson(response);
      } else {
        appLog("Failed to load products: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      appLog('Error fetching products: $e');
      return null;
    }
  }
}
