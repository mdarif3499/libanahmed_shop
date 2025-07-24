import 'package:ahmed_shop/screens/userScreen/cartScreen/orderProgress/models/parcel_tracking_models.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/viewOrder/model/view_order_model.dart'
    as ViewOrderModel;
import 'package:ahmed_shop/services/repository/order_repository/order_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OrderProgressController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isTracking = false.obs;
  var singleOrderList = <ViewOrderModel.ViewOrderModelData>[].obs;
  var trackOrderDataList = Rxn<ParcelDeliveryTrackingModel>();

  void showSingleOrderData(String orderId) async {
    isLoading.value = true;
    try {
      final response = await OrderRepository.showSingleOrder(orderId);
      if (response != null && response.data != null) {
        singleOrderList.clear();
        singleOrderList.add(response.data!);
      } else {
        singleOrderList.clear();
      }
    } catch (e) {
      singleOrderList.clear();
      appLog('Error fetching order data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void trackingOrder(String trackingNumber) async {
    try {
      isTracking(true);
      final response = await OrderRepository.trackingOrder(trackingNumber);
      if (response != null && response.data != null) {
        trackOrderDataList.value = response;
      } else {
        trackOrderDataList.value = null;
      }
    } catch (e) {
      appLog('Error tracking order: $e');
    } finally {
      isTracking(false);
    }
  }

  // Helper method to check if order is paid and has tracking number
  bool canTrackOrder() {
    if (singleOrderList.isEmpty) return false;
    final order = singleOrderList.first;
    return order.paymentStatus == 'paid' &&
        order.trackingNumber != null &&
        order.trackingNumber!.isNotEmpty;
  }

  // Helper method to get tracking number
  String? getTrackingNumber() {
    if (singleOrderList.isEmpty) return null;
    return singleOrderList.first.trackingNumber;
  }

  // Helper method to get current order status
  String getCurrentOrderStatus() {
    if (singleOrderList.isEmpty) return 'unknown';
    return singleOrderList.first.status ?? 'unknown';
  }

  // Helper method to get order progress percentage
  double getOrderProgress() {
    if (singleOrderList.isEmpty) return 0.0;

    final status = getCurrentOrderStatus();
    switch (status) {
      case 'completed':
        return 0.2;
      case 'recived':
        return 0.4;
      case 'ongoing':
        return 0.6;
      case 'delivery':
        return 0.8;
      case 'finished':
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  void onClose() {
    singleOrderList.clear();
    super.onClose();
  }
}
