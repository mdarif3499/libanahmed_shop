import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/models/track_order_models.dart'
    // ignore: library_prefixes
    as TrackOrderModel;
import 'package:ahmed_shop/services/repository/order_repository/order_repository.dart';
import 'package:ahmed_shop/services/repository/payment_repository/payment_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';

class UserTrackOrderController extends GetxController {
  RxBool isCompleteOrder = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOrderDeleted = false.obs;
  RxBool isPaymentLoading = false.obs;
  RxBool isShippingLoading = false.obs;
  var orderList = <TrackOrderModel.TrackOrderModelList>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllOrder("pending");
  }

  void toggleOrderState(bool isComplete) {
    isCompleteOrder.value = isComplete;
    if (isComplete) {
      getAllOrder("paid");
    } else {
      getAllOrder("pending");
    }
  }

  void getAllOrder(String action) async {
    isLoading.value = true;
    try {
      final response = await OrderRepository.fetchAllOrder(action);
      if (response != null && response.data != null) {
        orderList.assignAll(response.data!);
      } else {
        orderList.clear();
      }
    } catch (e) {
      orderList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void deleteOrder(String orderId) async {
    isOrderDeleted(true);
    try {
      final response = await OrderRepository.deleteOrder(orderId);
      if (response == true) {
        getAllOrder("pending");
        AppSnackBar.success('Order deleted successfully');
      }
    } catch (e) {
      AppSnackBar.error('Failed to delete order');
    } finally {
      isOrderDeleted(false);
    }
  }

  void payOrder(String orderId) async {
    isPaymentLoading(true);
    try {
      final response = await PaymentRepository.userPayment(
        orderId: orderId,
        shippingCost: 30,
      );

      if (response == true) {
        // Payment URL opened successfully
        // The actual payment completion will be handled by the payment screen
        AppSnackBar.success('Payment URL opened successfully');
      } else {
        AppSnackBar.error('Failed to initiate payment');
      }
    } catch (e) {
      AppSnackBar.error('Payment failed: ${e.toString()}');
    } finally {
      isPaymentLoading(false);
    }
  }

  void addShippingCharge (String orderId) async {
    try {
      isShippingLoading(true);
      final response = await OrderRepository.addShipingCharge(orderId);
      if (response == true) {
        AppSnackBar.success('Shipping charge added successfully');
      } else {
        AppSnackBar.error('Failed to add shipping charge');
      }
    } catch (e) {
      AppSnackBar.error('Failed to add shipping charge');
    } finally {
      isShippingLoading(false);
    }
  }
}
