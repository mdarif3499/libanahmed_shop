import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderDetails/models/owner_order_details_model.dart';
import 'package:ahmed_shop/services/repository/owner_order_repository/owner_order_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerOrderDetailsController extends GetxController {
  RxBool isViewingOrder = false.obs;
  var detailsList = Rxn<ViewOrderModelData>();

  void showSingleOrderData(String orderId) async {
    isViewingOrder.value = true;
    try {
      final response = await OwnerOrderRepository.showSingleOrder(orderId);
      if (response != null && response.data != null) {
        detailsList.value = response.data!;
      } else {
        detailsList.value = null;
      }
    } catch (e) {
      detailsList.value = null;
      appLog('Error fetching order data: $e');
    } finally {
      isViewingOrder.value = false;
    }
  }
}
