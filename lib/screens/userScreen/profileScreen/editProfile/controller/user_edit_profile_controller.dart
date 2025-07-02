import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ahmed_shop/services/repository/profile_repository/profile_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class UserEditProfileController extends GetxController {
  // Observable variables to track selected image and input fields
  var selectedImage = Rx<File?>(null);
  var currentImageUrl = Rx<String>(''); // To store current profile image URL
  var userName = Rx<String>('');
  var address = Rx<String>('');
  var phoneNumber = Rx<String>('');
  var isLoading = RxBool(false);

  final ImagePicker _picker = ImagePicker();

  // Text controllers for each input field
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Load existing profile data
    loadExistingProfile();
    
    // Add listeners to sync text controllers with observable variables
    userNameController.addListener(() {
      userName.value = userNameController.text;
    });
    
    addressController.addListener(() {
      address.value = addressController.text;
    });
    
    phoneNumberController.addListener(() {
      phoneNumber.value = phoneNumberController.text;
    });
    
    // Initialize the values from the controllers
    userName.value = userNameController.text;
    address.value = addressController.text;
    phoneNumber.value = phoneNumberController.text;
  }

  // Method to load existing profile data
  Future<void> loadExistingProfile() async {
    try {
      var profileData = await ProfileRepository.fetchUserProfile();
      if (profileData != null) {
        // Update text controllers with existing data
        userNameController.text = profileData.data?.fullName ?? '';
        addressController.text = profileData.data?.address ?? '';
        phoneNumberController.text = profileData.data?.phone ?? '';
        
        // Update observable variables
        userName.value = profileData.data?.fullName ?? '';
        address.value = profileData.data?.address ?? '';
        phoneNumber.value = profileData.data?.phone ?? '';
        
        // Store current image URL
        currentImageUrl.value = profileData.data?.image ?? '';
      }
    } catch (e) {
      print('Error loading existing profile: $e');
    }
  }

  // Method to pick and compress image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800, // Limit width to 800px
      maxHeight: 800, // Limit height to 800px
      imageQuality: 70, // Compress to 70% quality
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Method to convert image to base64 string for API upload with compression
  Future<String> convertImageToBase64(File imageFile) async {
    try {
      // Read image bytes
      Uint8List imageBytes = await imageFile.readAsBytes();
      
      // Check file size (limit to ~500KB for base64)
      if (imageBytes.length > 500000) {
        throw Exception('Image too large. Please select a smaller image.');
      }
      
      String base64String = base64Encode(imageBytes);
      return base64String;
    } catch (e) {
      throw Exception('Failed to process image: $e');
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

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      
      // Get the current values from text controllers
      String currentUserName = userNameController.text.trim();
      String currentAddress = addressController.text.trim();
      String currentPhoneNumber = phoneNumberController.text.trim();
      
      // Validate that required fields are not empty
      if (currentUserName.isEmpty || currentAddress.isEmpty || currentPhoneNumber.isEmpty) {
        AppSnackBar.error("Please fill in all required fields");
        return;
      }
      
      // Handle image upload
      String imageToSend = '';
      if (selectedImage.value != null) {
        try {
          // Show processing message
          AppSnackBar.success("Processing image...");
          
          // Convert new image to base64
          imageToSend = await convertImageToBase64(selectedImage.value!);
        } catch (e) {
          AppSnackBar.error("Image processing failed: $e");
          return;
        }
      } else {
        // No new image selected, use existing image URL or empty string
        imageToSend = currentImageUrl.value;
      }
      
      var response = await ProfileRepository.updateUserProfile(
        fullName: currentUserName,
        phone: currentPhoneNumber,
        address: currentAddress,
        image: imageToSend,
      );
      
      if (response == true) {
        AppSnackBar.success("Profile updated successfully");
        // Update current image URL if new image was uploaded
        if (selectedImage.value != null) {
          currentImageUrl.value = imageToSend;
          selectedImage.value = null; // Clear selected image after successful upload
        }
        Get.back();
      } else {
        AppSnackBar.error("Failed to update profile. Please try again.");
      }
    } catch (e) {
      if (e.toString().contains('timeout') || e.toString().contains('SocketException')) {
        AppSnackBar.error("Connection timeout. Please check your internet and try again.");
      } else {
        AppSnackBar.error("Error: Failed to update profile");
      }
    } finally {
      isLoading.value = false;
    }
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