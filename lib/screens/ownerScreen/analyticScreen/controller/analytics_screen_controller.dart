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

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  void fetchAllData() {
    fetchOverView();
    fetchIncomeRatio();
  }

  // Test method to create sample data for debugging
  void createTestData() {
    final testData = SellerIncomeRatioModel(
      success: true,
      message: "Test data",
      data: [
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 6)),
          totalIncome: 100.0,
        ),
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 5)),
          totalIncome: 150.0,
        ),
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 4)),
          totalIncome: 200.0,
        ),
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 3)),
          totalIncome: 120.0,
        ),
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 2)),
          totalIncome: 180.0,
        ),
        Datum(
          dateHour: DateTime.now().subtract(const Duration(days: 1)),
          totalIncome: 250.0,
        ),
        Datum(dateHour: DateTime.now(), totalIncome: 300.0),
      ],
    );

    incomeRatioList.value = testData;
    appLog("Test data created with ${testData.data?.length} items");
  }

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
        appLog("Income ratio data fetched successfully");
        appLog("Data count: ${data.data?.length ?? 0}");
        appLog(incomeRatioList.value?.toRawJson());

        // Debug individual data points
        data.data?.forEach((datum) {
          appLog("Date: ${datum.dateHour}, Income: ${datum.totalIncome}");
        });
      } else {
        appLog("No income ratio data received from API");
      }
      isIncomeRatioLoading(false);
    } catch (e) {
      isIncomeRatioLoading(false);
      appLog("Error fetching income ratio: ${e.toString()}");
    }
  }
}
