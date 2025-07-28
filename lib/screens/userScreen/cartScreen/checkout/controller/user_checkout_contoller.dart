import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/controller/user_cart_screen_controller.dart';
import 'package:ahmed_shop/services/repository/order_repository/order_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCheckoutContoller extends GetxController {
  RxBool isCheckOutCompleted = false.obs;
  var postalCode = TextEditingController();
  var phoneNumber = TextEditingController();
  final RxString completePhoneNumber = ''.obs;
  var stateCode = TextEditingController();
  var cityName = TextEditingController();
  var countryCode = TextEditingController();
  var addressLine1 = TextEditingController();
  var addressLine2 = TextEditingController();

  void updatePhoneNumber(String phoneNumber) {
    completePhoneNumber.value = phoneNumber;
  }

  void orderCheckout(
    String zipCode,
    String streetName,
    String stateCode,
    String phoneNumber,
    String locality,
    String houseNumnber,
    String country,
    String address,
  ) async {
    isCheckOutCompleted(true);

    try {
      var response = await OrderRepository.createOrder(
        postalCode: postalCode.text.trim(),
        phoneNumber: phoneNumber.trim(),
        stateCode: stateCode.trim(),
        cityName: cityName.text.trim(),
        countryCode: countryCode.text.trim(),
        addressLine1: addressLine1.text.trim(),
        addressLine2: addressLine2.text.trim(),
      );

      if (response != null && response == true) {
        AppSnackBar.success("Order created successfully!");
        // Clear all fields after successful order
        _clearAllFields();
        // Navigate back or to success page
        Get.find<CartController>().fetchCartProduct();
        Get.back();
      } else {
        AppSnackBar.error("Failed to create order. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred: ${e.toString()}");
    } finally {
      isCheckOutCompleted(false);
    }
  }

  void _clearAllFields() {
    postalCode.clear();
    completePhoneNumber.value = '';
    stateCode.clear();
    cityName.clear();
    countryCode.clear();
    addressLine1.clear();
    addressLine2.clear();
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    postalCode.dispose();
    stateCode.dispose();
    cityName.dispose();
    countryCode.dispose();
    addressLine1.dispose();
    addressLine2.dispose();
    super.onClose();
  }
}
