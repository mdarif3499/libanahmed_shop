import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerEditProfileController extends GetxController {
  // Observable variables to track selected image and input fields
  var selectedImage = Rx<File?>(null);
  var userName = Rx<String>('');
  var address = Rx<String>('');
  var phoneNumber = Rx<String>('');

  final ImagePicker _picker = ImagePicker();

  // Text controllers for each input field
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path); // Update selected image
    }
  }

  // Method to update the userName
  void updateUserName(String value) {
    userName.value = value;
  }

  // Method to update the address
  void updateAddress(String value) {
    address.value = value;
  }

  // Method to update the phone number
  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize the values from the controllers
    userName.value = userNameController.text;
    address.value = addressController.text;
    phoneNumber.value = phoneNumberController.text;
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose of controllers when not needed
    userNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
  }
}
