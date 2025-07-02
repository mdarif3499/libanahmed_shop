import 'package:ahmed_shop/services/repository/order_repository/order_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCheckoutContoller extends GetxController {
  RxBool isCheckOutCompleted = false.obs;
  var zipCode = TextEditingController();
  var streetName = TextEditingController();
  var stateCode = TextEditingController();
  var phoneNumber = TextEditingController();
  var locality = TextEditingController();
  var houseNumnber = TextEditingController();
  var country = TextEditingController();
  var address = TextEditingController();
  final RxString completePhoneNumber = ''.obs;

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
      String address) async {
    isCheckOutCompleted(true);

    try {
      var response = await OrderRepository.createOrder(
        zipCode: zipCode,
        streetName: streetName,
        stateCode: stateCode,
        phoneNumber: phoneNumber,
        locality: locality,
        houseNumnber: houseNumnber,
        country: country,
        address: address,
      );

      if (response != null && response == true) {
        AppSnackBar.success("Order created successfully!");
        // Clear all fields after successful order
        _clearAllFields();
        // Navigate back or to success page
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
    zipCode.clear();
    streetName.clear();
    stateCode.clear();
    phoneNumber.clear();
    locality.clear();
    houseNumnber.clear();
    country.clear();
    address.clear();
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    zipCode.dispose();
    streetName.dispose();
    stateCode.dispose();
    phoneNumber.dispose();
    locality.dispose();
    houseNumnber.dispose();
    country.dispose();
    address.dispose();
    super.onClose();
  }
}
