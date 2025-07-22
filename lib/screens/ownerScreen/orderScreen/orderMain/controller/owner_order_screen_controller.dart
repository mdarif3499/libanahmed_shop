import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/models/owner_order_model.dart'
    as OwnerOrderModel;
import 'package:ahmed_shop/services/repository/owner_order_repository/owner_order_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerOrderScreenController extends GetxController {
  RxBool isOngoingOrdertoggle = true.obs;
  RxBool isLoading = false.obs;

  // Use RxList for better reactivity
  RxList<OwnerOrderModel.Data> pendingOrderList =
      <OwnerOrderModel.Data>[].obs;
  RxList<OwnerOrderModel.Data> paidOrderList = <OwnerOrderModel.Data>[].obs;

  // Computed property to get current orders data
  List<OwnerOrderModel.Data> get currentOrdersData {
    return isOngoingOrdertoggle.value ? pendingOrderList : paidOrderList;
  }

  @override
  void onInit() {
    super.onInit();
    // Load both types of orders on init
    getAllOrders();
  }

  void toggleOngoingOrder(bool isOngoingOrder) {
    isOngoingOrdertoggle.value = isOngoingOrder;

    // Add debug logging
    appLog(
      'Toggle changed to: ${isOngoingOrder ? "Ongoing (pending)" : "Completed (paid)"}',
    );
    appLog('Current pending orders count: ${pendingOrderList.length}');
    appLog('Current paid orders count: ${paidOrderList.length}');
    appLog('Current display count: ${currentOrdersData.length}');

    // Ensure the correct list is populated
    if (isOngoingOrder && pendingOrderList.isEmpty) {
      getOwnerOrder('pending');
    } else if (!isOngoingOrder && paidOrderList.isEmpty) {
      getOwnerOrder('paid');
    }
  }

  Future<void> getAllOrders() async {
    // Load both pending and paid orders
    await getOwnerOrder('pending');
    await getOwnerOrder('paid'); // This line was commented out - uncomment it
  }

  Future<void> getOwnerOrder(String action) async {
    try {
      isLoading.value = true;

      appLog('Fetching $action orders...');
      final response = await OwnerOrderRepository.fetchAlltheOwnerOrders(
        action,
      );


      if (response != null) {
        appLog('Response success: ${response.success}');
        appLog('Response message: ${response.message}');
        appLog('Response data length: ${response.data?.length ?? 0}');

        // Check if response has data
        if (response.data != null && response.data!.isNotEmpty) {
          appLog('Successfully fetched ${response.data!.length} $action orders');

          // Store in appropriate list based on action
          if (action == 'pending') {
            pendingOrderList.assignAll(response.data!);
            appLog('Stored ${response.data!.length} orders in pendingOrderList');
          } else if (action == 'paid') {
            paidOrderList.assignAll(response.data!);
            appLog('Stored ${response.data!.length} orders in paidOrderList');
          }

          // Log sample data for debugging
          final sampleOrder = response.data!.first;
          appLog('Sample order ID: ${sampleOrder.id}');
          appLog('Sample order status: ${sampleOrder.status}');
          appLog('Sample order total: ${sampleOrder.totalAmount}');
        } else {
          appLog('No data received for $action orders - data array is empty or null');
          
          // Clear appropriate list when no data is received
          if (action == 'pending') {
            pendingOrderList.clear();
          } else if (action == 'paid') {
            paidOrderList.clear();
          }
        }
      } else {
        appLog('API returned null response for $action orders');
        
        // Clear appropriate list when response is null
        if (action == 'pending') {
          pendingOrderList.clear();
        } else if (action == 'paid') {
          paidOrderList.clear();
        }
      }
    } catch (e) {
      appLog('Error fetching $action orders: $e');

      // Clear appropriate list on error
      if (action == 'pending') {
        pendingOrderList.clear();
      } else if (action == 'paid') {
        paidOrderList.clear();
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to refresh current orders
  void refreshCurrentOrders() {
    if (isOngoingOrdertoggle.value) {
      getOwnerOrder('pending');
    } else {
      getOwnerOrder('paid');
    }
  }

  // Helper method to refresh all orders
  void refreshAllOrders() {
    getAllOrders();
  }

  // Helper methods for debugging
  int get pendingOrdersCount => pendingOrderList.length;

  int get paidOrdersCount => paidOrderList.length;

  int get currentOrdersCount => currentOrdersData.length;
}