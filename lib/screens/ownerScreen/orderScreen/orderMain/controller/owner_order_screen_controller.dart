import 'package:get/get.dart';

class OwnerOrderScreenController extends GetxController {
  RxBool isOngoingOrder = true.obs;

  void toggleOngoingOrder() {
    isOngoingOrder.value = !isOngoingOrder.value;
  }
}
