import 'package:ahmed_shop/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCheckOutScreenController extends GetxController {
  // To manage the screen index (navigation between different sections)
  RxInt screenIndex = 0.obs;

  // Controllers for user inputs
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController paymentMethod = TextEditingController();

  // Flags for loading states
  RxBool isLoading = false.obs;

  // User details for display
  String userEmail = 'rumenhussen@gmail.com';
  String userPhone = '+88-692-764-269';
  String userAddress = 'Newhall St 36, London, 12908 - UK';
  String paymentCardLastDigits = '0696 4629';

  // Order details (these can come from a cart or order service)
  double subtotal = 1250.00;
  double shippingCost = 40.00;
  double totalCost = 1690.00;

  // Method to simulate placing an order (for demonstration purposes)
  placeOrder() async {
    if (phoneNumber.text.isNotEmpty && address.text.isNotEmpty) {
      try {
        isLoading.value = true;
        Map<String, dynamic> orderDetails = {
          "email": userEmail,
          "phone": phoneNumber.text,
          "address": address.text,
          "paymentMethod":
              paymentMethod.text.isEmpty ? "Stripe" : paymentMethod.text,
          "totalCost": totalCost,
        };

        appLog(orderDetails);

        // Simulate a network call to place the order
        await Future.delayed(const Duration(seconds: 2));
        // After placing the order, navigate to success screen
        Get.toNamed('/userPaymentSuccessScreen', arguments: orderDetails);
      } catch (e) {
        appLog("Error in placing order: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      appLog("Phone number or address is empty.");
    }
  }

  // Method to handle payment (simplified for now)
  handlePayment() {
    appLog("Initiating payment for total cost: \$$totalCost");
    placeOrder();
  }

  @override
  void onInit() {
    super.onInit();
    // You can initialize any necessary data here
    paymentMethod.text = "Stripe"; // Example payment method
  }
}
