import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../services/repository/customer_auth_repository/auth_repository.dart';
import '../../../../../utils/error_log.dart';
import '../../../../../widgets/app_snack_bar/app_snack_bar.dart';

class CreateAccountController extends GetxController {
  final AuthRepository authRepository = AuthRepository();

  // Controllers for form fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // To track whether the user is on login or sign-up screen
  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;

  // Reactive variable for "Remember Me"
  RxBool isRememberMeChecked = false.obs;

  // GlobalKey for form validation
  final formKey = GlobalKey<FormState>();

  // Dispose all controllers when they are no longer needed
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle between login and signup view
  void toggleLoginSignup() {
    isLogin.value = !isLogin.value;
  }

  // Form validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please provide a valid email address';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Logic to handle "Remember Me" checkbox
  void toggleRememberMe(bool? value) {
    isRememberMeChecked.value = value ?? false;
  }

  // Register User

  Future<void> registerUser() async {
    try {
      isLoading.value = true; // Show loading indicator
      bool isRegistered = await authRepository.registerUser(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      if (isRegistered) {
        AppSnackBar.success("Registration successful!");
        Get.offAllNamed(AppRoutes.userRegistrationOtpVerificationScreen,
            arguments: emailController.text);
      }
    } catch (e) {
      errorLog("registerUser controller function", e);
      AppSnackBar.error("An error occurred during registration.");
    } finally {
      isLoading.value = false; 
    }
  }

  // Login User
  Future<void> loginUser() async {
    try {
      isLoading.value = true; 

      // Validate email and password
      if (emailController.text.trim().isEmpty ||
          passwordController.text.trim().isEmpty) {
        AppSnackBar.error("Email and password are required.");
        return;
      }

      bool isLoggedIn = await authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (isLoggedIn) {
        AppSnackBar.success("Login successful!");
        Get.offAllNamed(
            AppRoutes.userNavigationScreen); 
      } else {
        AppSnackBar.error("Invalid email or password.");
      }
    } catch (e) {
      errorLog("loginUser controller function", e);
      AppSnackBar.error("An error occurred during login. Please try again.");
    } finally {
      isLoading.value = false; 
    }
  }
}
