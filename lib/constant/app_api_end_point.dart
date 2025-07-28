import 'package:ahmed_shop/utils/error_log.dart';
import 'package:flutter/foundation.dart';

String _getDomain() {
  // Check if the IP is accessible, if not, you might need to update this
  // to your actual server IP or domain
  String liveServer = "http://3.141.148.237:5003";
  String localServer = "http://3.141.148.237:5003";

  // For testing, you can try using localhost if you're running on an emulator
  // String localServer = "http://localhost:5003";
  // Or 10.0.2.2 for Android emulator to access host machine
  // String localServer = "http://10.0.2.2:5003";

  try {
    if (kDebugMode) {
      return localServer;
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
  final String imageBaseUrl = "http://3.141.148.237:5003/";
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
  final String deleteOrder = "/order/";
  final String rating = "/review";
  final String userProfileSettings = "/setting";
  final String favouriteProduct = "/favorite-product";
  final String addShipingCharge = "/shipping/rates";
  final String trackingOrder = "/shipping/tacking/";

  //! Owner Product End Points
  final String ownerAllProduct = "/product/seller";
  final String ownerAllProducts = "/product/seller";
  final String ownerProfileSettings = "/setting";
  final String ownerProfile = "/users/my-profile";
  final String ownerShopCreation = "/shop/create-shop";
  final String ownerProductCreate = "/product/create-product";
  final String ownerOrder = "/order?paymentStatus=";
  final String ownerBestSellingItem = "/product/best-selling";
  final String ownerOverView = "/product/overview";
  final String ownerIncomeRatio = "/payment/all-income-rasio-by-days?days=7day";
  final String ownerEditProduct = "/product/";
  final String offerCreate = "/offer/add-offer";
  final String ownerCreateOffer = "/product/all-product-for-offer";
  final String ownerConnectedPayment =
      "/payment/create-stripe-connected-account";
}
