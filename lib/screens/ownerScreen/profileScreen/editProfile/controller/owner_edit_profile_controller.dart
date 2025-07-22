import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ahmed_shop/services/repository/owner_profile_repository/owner_profle_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerEditProfileController extends GetxController {
  // Observable variables to track selected image and input fields
  var selectedImage = Rx<File?>(null);
  var currentImageUrl = Rx<String>('');
  var userName = Rx<String>('');
  var phoneNumber = Rx<String>('');
  var addressLine1 = Rx<String>('');
  var addressLine2 = Rx<String>('');
  var city = Rx<String>('');
  var countryCode = Rx<String>('');
  var stateCode = Rx<String>('');
  var postalCode = Rx<String>('');
  var isLoading = RxBool(false);

  final ImagePicker picker = ImagePicker();

  //! Text controllers for each input field
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController stateCodeController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //! Load Existing Profile Data
    loadExistingOwnerProfile();

    //! Add Listeners to sync text Controller with Observable variables
    userNameController.addListener(() {
      updateUserName(userNameController.text);
    });
    phoneNumberController.addListener(() {
      updatePhoneNumber(phoneNumberController.text);
    });
    addressLine1Controller.addListener(() {
      updateAddressline2(addressLine1Controller.text);
    });

    addressLine2Controller.addListener(() {
      updateAddressline2(addressLine2Controller.text);
    });
    cityController.addListener(() {
      updateCity(cityController.text);
    });
    countryCodeController.addListener(() {
      updateCountryCode(countryCodeController.text);
    });
    stateCodeController.addListener(() {
      updateStateCode(stateCodeController.text);
    });
    postalCodeController.addListener(() {
      updatePostalCode(postalCodeController.text);
    });
    // Initialize the values from the controllers
    userName.value = userNameController.text;
    phoneNumber.value = phoneNumberController.text;
    addressLine1.value = addressLine1Controller.text;
    addressLine2.value = addressLine2Controller.text;
    city.value = cityController.text;
    countryCode.value = countryCodeController.text;
    stateCode.value = stateCodeController.text;
    postalCode.value = postalCodeController.text;
  }

  //! Method to pick and compress image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 10,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  //! Method to convert image to base64 string for API upload with compression
  Future<String> convertImageToBase64(File imageFile) async {
    try {
      //! Read image bytes
      Uint8List imageBytes = await imageFile.readAsBytes();

      //! Check file size (limit to ~500KB for base64)
      if (imageBytes.length > 500000) {
        throw Exception('Image too large. Please select a smaller image.');
      }

      String base64String = base64Encode(imageBytes);
      return base64String;
    } catch (e) {
      throw Exception('Failed to process image: $e');
    }
  }

  //!! Method to update the userName
  void updateUserName(String value) {
    userName.value = value;
  }

  //!! Method to update the address2
  void updateAddressline2(String value) {
    addressLine2.value = value;
  }

  //! Method to update city
  void updateCity(String value) {
    city.value = value;
  }

  //! Method to update countrycode
  void updateCountryCode(String value) {
    countryCode.value = value;
  }

  //! Method to update state code
  void updateStateCode(String value) {
    stateCode.value = value;
  }

  //! Method to update postal code
  void updatePostalCode(String value) {
    postalCode.value = value;
  }

  //! Method to update the phone number
  void updatePhoneNumber(String value) {
    phoneNumber.value = value;
  }

  //! Method to Load Existing Profile Data
  Future<void> loadExistingOwnerProfile() async {
    try {
      var ownerProfileData = await OwnerProfleRepository.fetchProfile();
      if (ownerProfileData != null) {
        //! Update Text Controller with Existing Data
        userNameController.text = ownerProfileData.data?.fullName ?? '';
        phoneNumberController.text = ownerProfileData.data?.phone ?? '';
        addressLine1Controller.text = ownerProfileData.data?.addressLine1 ?? '';
        cityController.text = ownerProfileData.data?.city ?? '';
        countryCodeController.text = ownerProfileData.data?.countryCode ?? '';
        stateCodeController.text = ownerProfileData.data?.stateCode ?? '';
        postalCodeController.text = ownerProfileData.data?.postalCode ?? '';

        //!Update Observable variables
        userName.value = ownerProfileData.data?.fullName ?? '';
        phoneNumber.value = ownerProfileData.data?.phone ?? '';
        addressLine1.value = ownerProfileData.data?.addressLine1 ?? '';
        addressLine2.value = ownerProfileData.data?.addressLine2 ?? '';
        city.value = ownerProfileData.data?.city ?? '';
        countryCode.value = ownerProfileData.data?.countryCode ?? '';
        stateCode.value = ownerProfileData.data?.stateCode ?? '';
        postalCode.value = ownerProfileData.data?.postalCode ?? '';

        //! currentImageUrl Store
        currentImageUrl.value = ownerProfileData.data?.image ?? '';
      }
    } catch (e) {
      appLog('Error loading existing profile: $e');
    }
  }

  //! Update The Owner Profile
  Future<void> updateOwnerProfile() async {
    try {
      isLoading(true);

      //! Getting the current value
      String currentUserName = userNameController.text.trim();

      String currentPhoneNumber = phoneNumberController.text.trim();

      String currentAddressLine1 = addressLine1Controller.text.trim();

      String currentAddressLine2 = addressLine2Controller.text.trim();

      String currentCity = cityController.text.trim();

      String currentCountryCode = countryCodeController.text.trim();
      String currentStateCode = stateCodeController.text.trim();

      String currentPostalCode = postalCodeController.text.trim();

      //! Validate field
      if (currentUserName.isEmpty ||
          currentPhoneNumber.isEmpty ||
          currentAddressLine1.isEmpty ||
          currentAddressLine2.isEmpty ||
          currentCity.isEmpty ||
          currentCountryCode.isEmpty ||
          currentStateCode.isEmpty ||
          currentPostalCode.isEmpty) {
        AppSnackBar.error("Please fill in all fields");
        return;
      }
      //! Handle Image Upload
      String imageToSend = '';
      if(selectedImage.value != null){
        try {
          // Show Image processing 
          AppSnackBar.success("Processing Image...");
          // Convert image to base64
          imageToSend = await convertImageToBase64(selectedImage.value!);
        } catch (e) {
          AppSnackBar.error("Error processing image: $e");
          return;
        }
      } else {
        // Use the current image URL if no new image is selected
        imageToSend = currentImageUrl.value;
      }

      var response = await OwnerProfleRepository.updateOwnerProfile(fullName: currentUserName, phone: currentPhoneNumber, image: imageToSend, addressLine1: currentAddressLine1, addressLine2: currentAddressLine2, city: currentCity, stateCode: currentStateCode, countryCode: currentCountryCode, postalCode: currentPostalCode);

      if (response != null) {
        AppSnackBar.success("Profile Updated Successfully");
        if (selectedImage.value != null) {
          currentImageUrl.value = imageToSend;
          selectedImage.value = null; // Clear selected image after successful upload
        }
        Get.back();
      }else {
        AppSnackBar.error("Failed to update profile. Please try again.");
      }


    } catch (e) {
      if (e.toString().contains('timeout') ||
          e.toString().contains('SocketException')) {
        AppSnackBar.error(
          "Connection timeout. Please check your internet and try again.",
        );
      } else {
        AppSnackBar.error("Error: Failed to update profile");
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Dispose of controllers when not needed
    userNameController.dispose();
    phoneNumberController.dispose();
    addressLine1.dispose();
    addressLine2.dispose();
    city.dispose();
    countryCode.dispose();
    stateCode.dispose();
    postalCode.dispose();
  }
}
