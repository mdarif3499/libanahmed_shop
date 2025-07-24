import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderDetails/models/owner_order_details_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderProgress/models/owner_order_tracking_model.dart';
import 'package:ahmed_shop/services/repository/owner_order_repository/owner_order_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerOrderProgressController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isTrackingLoading = false.obs;
  var detailsList = Rxn<ViewOrderModelData>();
  var trackingOrderDataList = Rxn<OwnerOrderTrackingModel>();

  void showSingleOrderData(String orderId) async {
    isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  void showTrackingOrderData(String trackingNumber) async {
    isTrackingLoading.value = true;
    try {
      final response = await OwnerOrderRepository.trackingOrder(trackingNumber);
      if (response != null && response.data != null) {
        trackingOrderDataList.value = response;
      } else {
        trackingOrderDataList.value = null;
      }
    } catch (e) {
      trackingOrderDataList.value = null;
      appLog('Error fetching tracking data: $e');
    } finally {
      isTrackingLoading.value = false;
    }
  }

  // Helper method to check if order has tracking number
  bool canTrackOrder() {
    if (detailsList.value == null) return false;
    final order = detailsList.value!;
    return order.trackingNumber != null && order.trackingNumber!.isNotEmpty;
  }

  // Helper method to get tracking number
  String? getTrackingNumber() {
    if (detailsList.value == null) return null;
    return detailsList.value!.trackingNumber;
  }

  // Helper method to check if order is paid
  bool isOrderPaid() {
    if (detailsList.value == null) return false;
    return detailsList.value!.paymentStatus == 'paid';
  }
}
