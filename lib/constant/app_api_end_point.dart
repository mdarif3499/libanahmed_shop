import 'package:ahmed_shop/utils/error_log.dart';
import 'package:flutter/foundation.dart';

String _getDomain() {
  String liveServer = "https://humayon5003.binarybards.online";
  String localServer = "";

  try {
    if (kDebugMode) {
      localServer;
      // return localServer;
    }
    return liveServer;
  } catch (e) {
    errorLog("_getDomain", e);
    return liveServer;
  }
}

class ApiUrls {
  ApiUrls._privateConstructor();

  static final ApiUrls _instance = ApiUrls._privateConstructor();

  static ApiUrls get instance => _instance;

  //app use base
  final String domain = _getDomain();
  final String baseUrl = "${_getDomain()}/api/v1";
  final String liveServer = "https://";

  //Auth end point
  final String imageBaseUrl = "https://humayon5003.binarybards.online/";
  final String register = "/users/create";
  final String registerVerifyOtp = "/users/create-user-verify-otp";
  final String resendOtp = "/otp/resend-otp";
  final String login = "/auth/login";
  final String forgotPassword = "/auth/forgot-password-otp";
  final String forgotPasswordOtpMatch = "/auth/forgot-password-otp-match";
  final String resetPassword = "/auth/forgot-password-reset";
  final String resendForgotPasswordOtp = "/otp/resend-otp";

  //! Product End Points
  final String allProducts = "/product";
  final String categories = "/category?isActive=";
  final String addToCart = "/cart/create-cart";
  final String cartProduct = "/cart";
  final String userProfile = "/users/my-profile";
  final String userProfileUpdate = "/users/update-my-profile";
  final String createOrder = "/order/create-order";
  final String trackOrder = "/order?paymentStatus=";
  final String viewOrder = "/order/";
  final String createPayment = "/payment/add-payment";
  final String rating = "/review";
  final String userProfileSettings = "/setting";

  //! Owner Product End Points
  final String ownerAllProduct = "/product/seller";
  final String ownerAllProducts = "/product/seller";
  final String ownerProfileSettings = "/setting";
  final String ownerShopCreation = "/shop/create-shop";
}
