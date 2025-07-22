import 'dart:async';
import 'dart:io';

import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:ahmed_shop/utils/shared_pref_helper/shared_pref_helper.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:dio/dio.dart';

class OwnerAuthRepository {
  ApiServices apiServices = ApiServices.instance;
  StorageServices appAuthStorage = StorageServices.instance;

  //! Login ShopOwner
  Future<bool> login({required String email, required String password}) async {
    try {
      // Log the request details for debugging
      appLog("Attempting login with email: $email");

      // Create a direct Dio instance with shorter timeouts
      final dio = Dio();
      dio.options.baseUrl = ApiUrls.instance.baseUrl;
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      dio.options.sendTimeout = const Duration(seconds: 10);

      appLog(
        "Using direct Dio with URL: ${dio.options.baseUrl}${ApiUrls.instance.login}",
      );

      // Make the request directly with Dio
      final response = await dio
          .post(
            ApiUrls.instance.login,
            data: {"email": email, "password": password},
            options: Options(headers: {"Content-Type": "application/json"}),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Request timed out after 10 seconds');
            },
          );

      appLog("Login response status: ${response.statusCode}");

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        if (data["data"] != null &&
            data["data"]["accessToken"] != null &&
            data["data"]["refreshToken"] != null) {
          await appAuthStorage.setToken(data["data"]["accessToken"]);
          await appAuthStorage.setUserRole(data["data"]["user"]["role"]);
          return true;
        } else {
          appLog("Login response missing required tokens");
          AppSnackBar.error(
            "Invalid response from server. Missing authentication tokens.",
          );
        }
      } else {
        appLog("Login response was unsuccessful: ${response.statusCode}");
        AppSnackBar.error("Server returned error: ${response.statusCode}");
      }
      return false;
    } on TimeoutException catch (e) {
      errorLog("login timeout exception", e);
      appLog("Login timeout: ${e.toString()}");
      AppSnackBar.error(
        "Login request timed out. Server might be unreachable.",
      );
      return false;
    } on SocketException catch (e) {
      errorLog("login socket exception", e);
      appLog("Socket error: ${e.toString()}");
      AppSnackBar.error("Network error. Please check your connection.");
      return false;
    } on DioException catch (e) {
      errorLog("login dio exception", e);
      appLog("Dio error: ${e.toString()}");

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        AppSnackBar.error("Connection timed out. Server might be unreachable.");
      } else if (e.type == DioExceptionType.connectionError) {
        AppSnackBar.error(
          "Cannot connect to server at ${ApiUrls.instance.baseUrl}. Check your network and server address.",
        );
      } else if (e.response != null) {
        AppSnackBar.error(
          "Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}",
        );
      } else {
        AppSnackBar.error("Network error: ${e.message}");
      }
      return false;
    } catch (e) {
      errorLog("login repo function", e);
      appLog("General error: ${e.toString()}");
      AppSnackBar.error("Login failed: ${e.toString().split('\n')[0]}");
      return false;
    }
  }

  //! Register ShopOwner
  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var response = await apiServices.apiPostServices(
        url: ApiUrls.instance.register,
        body: {
          "fullName": "$firstName $lastName",
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "role": "seller",
        },
      );

      if (response != null) {
        if (response["message"] != null) {
          AppSnackBar.message(response["message"].toString());
        }

        if (response["data"] != null &&
            response["data"]["createUserToken"] != null) {
          try {
            // Ensure SharedPreferences is initialized and store the token
            await SharePrefsHelper.setString(
              SharedPreferenceValue.createUserToken,
              response["data"]["createUserToken"],
            );
          } catch (e) {
            errorLog("SharedPreferences error", e);
            AppSnackBar.error("Failed to save user token. Please try again.");
            return false;
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      errorLog("registerUser repo function", e);
      AppSnackBar.error("Registration failed. Please try again.");
      return false;
    }
  }

  //! Verify OTP
  Future<bool> verifyOtp({required String otp}) async {
    try {
      var createUserToken = await SharePrefsHelper.getString(
        SharedPreferenceValue.createUserToken,
      );
      appLog("Retrieved token: '$createUserToken'");
      if (createUserToken.isEmpty) {
        AppSnackBar.error("Token not found. Please register again.");
        return false;
      }
      var headers = {"token": createUserToken};
      // Debug log to check headers
      appLog("Request headers: $headers");
      // Make the API call with the token in headers
      var response = await apiServices.apiPostServices(
        url: ApiUrls.instance.registerVerifyOtp,
        body: {"otp": otp},
        header: headers,
      );
      // Check the "success" field in the response
      if (response["success"] == true) {
        appLog("OTP verification successful =================$createUserToken");

        return true;
      }
      AppSnackBar.error("Invalid OTP or verification failed.");
      return false;
    } catch (e) {
      errorLog("verifyOtp repo function", e);
      // Check if it's a specific API error
      if (e.toString().contains('Token not found')) {
        AppSnackBar.error("Session expired. Please register again.");
      } else {
        AppSnackBar.error("OTP verification failed. Please try again.");
      }
      return false;
    }
  }

  //! Resend OTP
  Future<bool> resendOtp() async {
    try {
      // Retrieve the token from shared preferences
      var createUserToken = await SharePrefsHelper.getString(
        SharedPreferenceValue.createUserToken,
      );
      // Debug log to check retrieved token
      appLog("Retrieved token: '$createUserToken'");
      // Check if the token exists and is not empty
      if (createUserToken.isEmpty) {
        AppSnackBar.error("Token not found. Please register again.");
        return false;
      }
      // Prepare headers with proper Authorization format
      var headers = {"token": createUserToken};
      // Debug log to check headers
      appLog("Request headers: $headers");
      // Make the API call with the token in headers
      var response = await apiServices.apiPatchServices(
        url: ApiUrls.instance.resendOtp,
        options: Options(headers: headers),
      );
      // Check the "success" field in the response
      if (response["success"] == true) {
        appLog(
          "OTP verification successful ==============================$createUserToken",
        );
        // Clear the temporary token after successful verification
        // await SharePrefsHelper.removeString(SharedPreferenceValue.createUserToken);
        return true;
      }
      AppSnackBar.error("Invalid OTP or verification failed.");
      return false;
    } catch (e) {
      errorLog("verifyOtp repo function", e);
      // Check if it's a specific API error
      if (e.toString().contains('Token not found')) {
        AppSnackBar.error("Session expired. Please register again.");
      } else {
        AppSnackBar.error("OTP verification failed. Please try again.");
      }
      return false;
    }
  }

  //! Has Valid Registration Token
  Future<bool> hasValidRegistrationToken() async {
    try {
      var token = await SharePrefsHelper.getString(
        SharedPreferenceValue.createUserToken,
      );
      return token.isNotEmpty;
    } catch (e) {
      errorLog("hasValidRegistrationToken", e);
      return false;
    }
  }

  //! Forgot Password
  Future<Map<String, dynamic>?> forgotPassword({required String email}) async {
    try {
      var response = await apiServices.apiPostServices(
        url: ApiUrls.instance.forgotPassword,
        body: {"email": email},
      );
      if (response != null && response["success"] == true) {
        // Store the token in get storage
        await appAuthStorage.setForgotPasswordToken(
          response["data"]["forgetToken"],
        );

        // Show the log message the forgot password token
        appLog("Forgot Password Token: ${response["data"]["forgetToken"]}");
        AppSnackBar.success(response["message"] ?? "Email sent successfully.");
        return response;
      }
      AppSnackBar.error(response?["message"] ?? "Failed to send email.");
      return null;
    } catch (e) {
      errorLog("forgotPassword repo function", e);
      AppSnackBar.error("An error occurred. Please try again.");
      return null;
    }
  }

  //! Verify Forgot Password OTP
  Future<Map<String, dynamic>?> verifyForgotPasswordOtp({
    required String otp,
    required String token,
  }) async {
    try {
      var forgotPasswordToken = appAuthStorage.getForgotPasswordToken();
      var response = await apiServices.apiPatchServices(
        url: ApiUrls.instance.forgotPasswordOtpMatch,
        body: {"otp": otp}, // Send OTP as a string
        options: Options(
          headers: {"token": forgotPasswordToken},
        ), // Pass token in header
      );
      if (response != null) {
        if (response["message"] != null) {
          AppSnackBar.message(response["message"].toString());
        }
        return response; // Return the full response
      }
      return null; // Return null if the response is null
    } catch (e) {
      errorLog("verifyForgotPasswordOtp repo function", e);
      return null; // Return null in case of an exception
    }
  }

  //! Resend Forgot Password OTP
  Future<bool> resendForgotPasswordOtp() async {
    try {
      var forgotPasswordToken = appAuthStorage.getForgotPasswordToken();
      var response = await apiServices.apiPatchServices(
        url: ApiUrls.instance.resendForgotPasswordOtp,
        options: Options(headers: {"token": forgotPasswordToken}),
      );
      if (response != null) {
        if (response["message"] != null) {
          AppSnackBar.message(response["message"].toString());
        }
        return true; // Return true if the OTP resend is successful
      }
      return false; // Return false if the response is null
    } catch (e) {
      errorLog("resendForgotPasswordOtp repo function", e);
      AppSnackBar.error("Failed to resend OTP. Please try again.");
      return false; // Return false in case of an exception
    }
  }

  //! Reset Password
  Future<bool> resetPassword({
    required String newPassword,
    required String confirmPassword,
    required String token,
  }) async {
    try {
      var forgotPasswordToken = appAuthStorage.getForgotPasswordToken();
      var response = await apiServices.apiPatchServices(
        url: ApiUrls.instance.resetPassword,
        body: {"newPassword": newPassword, "confirmPassword": confirmPassword},
        options: Options(headers: {"token": forgotPasswordToken}),
      );
      if (response != null) {
        if (response["message"] != null) {
          AppSnackBar.message(response["message"].toString());
        }
        return true; // Return true if the password reset is successful
      }
      return false; // Return false if the response is null
    } catch (e) {
      errorLog("resetPassword repo function", e);
      AppSnackBar.error("Failed to reset password. Please try again.");
      return false; // Return false in case of an exception
    }
  }

  //! Has Valid Forgot Password Token
  Future<bool> hasValidForgotPasswordToken() async {
    try {
      var token = appAuthStorage.getForgotPasswordToken();
      return token.isNotEmpty;
    } catch (e) {
      errorLog("hasValidForgotPasswordToken", e);
      return false;
    }
  }
}
