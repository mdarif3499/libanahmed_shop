import 'package:ahmed_shop/constant/app_storage_key.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices {
  StorageServices._privateConstructor();
  static final StorageServices _instance = StorageServices._privateConstructor();
  static StorageServices get instance => _instance;

  ////////////// storage initial
  GetStorage box = GetStorage();

  ////////////////  token
  Future<void> setToken(String value) async {
    try {
      await box.write(AppStorageKey.instance.token, value);
      await box.save();
    } catch (e) {
      errorLog("set token ", e);
    }
  }

  String getToken() {
    try {
      return box.read(AppStorageKey.instance.token) ?? "";
    } catch (e) {
      errorLog("get token", e);
      return "";
    }
  }

  //// Forgot password token
  Future<void> setForgotPasswordToken(String value) async {
    try {
      await box.write(AppStorageKey.instance.forgotToken, value);
      await box.save();
    } catch (e) {
      errorLog("set forgot password token", e);
    }
  }
  String getForgotPasswordToken() {
    try {
      return box.read(AppStorageKey.instance.forgotToken) ?? "";
    } catch (e) {
      errorLog("get forgot password token", e);
      return "";
    }
  }

  //// Get Review 
  Future<void> setReviewToken(List<String> value) async {
    try {
      await box.write(AppStorageKey.instance.reviewToken, value);
      await box.save();
    } catch (e) {
      errorLog("set review token", e);
    }
  }
  String getReviewToken() {
    try {
      return box.read(AppStorageKey.instance.reviewToken) ?? "";
    } catch (e) {
      errorLog("get review token", e);
      return "";
    }
  }

  ///////////////////////  on board screen

  Future<void> setOnboardScreen() async {
    try {
      await box.write(AppStorageKey.instance.onboard, true);
      await box.save();
    } catch (e) {
      errorLog("setOnboardScreen", e);
    }
  }

  bool getOnboardScreen() {
    try {
      return box.read(AppStorageKey.instance.onboard) ?? false;
    } catch (e) {
      errorLog("getOnboardScreen", e);
      return false;
    }
  }

  /////////////////////  user role
  Future<void> setUserRole(String value) async {
    try {
      await box.write(AppStorageKey.instance.userRole, value);
    } catch (e) {
      errorLog("set user role", e);
    }
  }

  String? getUserRole() {
    try {
      return box.read(AppStorageKey.instance.userRole);
    } catch (e) {
      errorLog("get user role", e);
      return "";
    }
  }

  ////////////  get language
  String? getLanguage() {
    return box.read(AppStorageKey.instance.language);
  }

  ////////////  set language
  Future<void> setLanguage(String value) async {
    await box.write(AppStorageKey.instance.language, value);
  }

  ////////////  get country
  String getCountry() {
    return box.read(AppStorageKey.instance.country) ?? "";
  }

  ////////////  set country
  Future<void> setCountry(String value) async {
    await box.write(AppStorageKey.instance.country, value);
  }

  // NEW METHODS FOR REVIEWED ORDERS
  static const String _reviewedOrdersKey = 'reviewed_orders';

  // Save reviewed orders as comma-separated string
  Future<void> saveReviewedOrders(String reviewedOrders) async {
    try {
      await box.write(_reviewedOrdersKey, reviewedOrders);
      await box.save();
    } catch (e) {
      errorLog('Error saving reviewed orders', e);
    }
  }

  // Get reviewed orders string
  String? getReviewedOrders() {
    try {
      return box.read(_reviewedOrdersKey);
    } catch (e) {
      errorLog('Error getting reviewed orders', e);
      return null;
    }
  }

  // Clear reviewed orders (optional - for testing or user logout)
  Future<void> clearReviewedOrders() async {
    try {
      await box.remove(_reviewedOrdersKey);
      await box.save();
    } catch (e) {
      errorLog('Error clearing reviewed orders', e);
    }
  }

  ///logout
  Future<void> storageClear() async {
    try {
      await box.write(AppStorageKey.instance.token, "");
      await setLanguage("en_US");
      // Also clear reviewed orders on logout if needed
      await clearReviewedOrders();
    } catch (e) {
      errorLog("logout", e);
    }
  }
}