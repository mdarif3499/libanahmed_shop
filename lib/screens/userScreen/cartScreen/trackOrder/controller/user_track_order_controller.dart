// ignore: library_prefixes
import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/models/track_order_models.dart'
    as TrackOrderModel;
import 'package:ahmed_shop/services/repository/order_repository/order_repository.dart';
import 'package:get/get.dart';

class UserTrackOrderController extends GetxController {
  RxBool isCompleteOrder = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOrderDeleted = false.obs;
  var orderList = <TrackOrderModel.TrackOrderModelList>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load pending orders initially
    getAllOrder("pending");
  }

  // Toggle between ongoing and complete order
  void toggleOrderState(bool isComplete) {
    isCompleteOrder.value = isComplete;
    // Fetch data based on the new state
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
        orderList.clear(); // Clear the list if no data
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      orderList.clear(); // Clear the list on error
    }
  }

  void deleteOrder(String orderId)async {
    isOrderDeleted(true);
    try{
      final response = await OrderRepository.deleteOrder(orderId);
      if(response == true){
        getAllOrder("pending");
        isOrderDeleted(false);
      }
    }catch(e){
      isOrderDeleted(false);
    }
  }
}
