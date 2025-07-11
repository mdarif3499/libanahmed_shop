import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/models/owner_order_model.dart';
import 'package:ahmed_shop/services/repository/owner_order_repository/owner_order_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OwnerOrderScreenController extends GetxController {
  RxBool isOngoingOrdertoggle = true.obs;
  var isLoading = false.obs;
  var ownerOrderList = Rxn<OwnerOrderModel>();

  @override
  void onInit() {
    super.onInit();
    getOwnerOrder('pending');
  }

  void toggleOngoingOrder(bool isOngoingOrder) {
    isOngoingOrdertoggle.value = isOngoingOrder;
    if (isOngoingOrder) {
      getOwnerOrder('pending');
    } else {
      getOwnerOrder('paid');
    }
  }

  Future<void> getOwnerOrder(String action) async {
    try {
      isLoading(true);
      final response = await OwnerOrderRepository.fetchAlltheOwnerOrders(action);
      if (response != null && response.data != null) {
        ownerOrderList.value = response;
      }
      else {
        ownerOrderList.value = null;
      }
    } catch (e) {
      ownerOrderList.value = null;
      print('Error fetching orders: $e');
    } finally {
      isLoading(false);
    }
  }
}