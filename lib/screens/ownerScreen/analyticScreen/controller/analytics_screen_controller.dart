import 'package:ahmed_shop/screens/ownerScreen/analyticScreen/models/analytics_screen_models.dart';
import 'package:get/get.dart';

import '../../../../services/repository/owner_analytics_repository/owner_analytics_repository.dart';
import '../../../../utils/app_log.dart';
import '../models/analytics_screen_models_ratio.dart';

class OwnerAnalyticsScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isIncomeRatioLoading = false.obs;
  var overViewList = Rxn<SellerOverViewModel>();
  var incomeRatioList = Rxn<SellerIncomeRatioModel>();

  void fetchOverView() async {
    try {
      isLoading(true);
      var data = await OwnerAnalyticsRepository.getSellerOverview();
      if (data != null) {
        overViewList.value = data;
        appLog("Overview data fetched successfully");
        appLog(overViewList.value?.toRawJson());
      } else {
        appLog("No data received from API");
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      appLog("Error fetching overview: ${e.toString()}");
    }
  }

  void fetchIncomeRatio() async {
    try {
      isIncomeRatioLoading(true);
      var data = await OwnerAnalyticsRepository.getSellerIncomeRatio();
      if (data != null) {
        incomeRatioList.value = data;
        appLog("Overview data fetched successfully");
        appLog(incomeRatioList.value?.toRawJson());
      } else {
        appLog("No data received from API");
      }
      isIncomeRatioLoading(false);
    } catch (e) {
      isIncomeRatioLoading(false);
      appLog("Error fetching overview: ${e.toString()}");
    }
  }
}
