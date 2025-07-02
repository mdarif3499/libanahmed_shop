import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';

class SettingRepository {
  // Use StorageServices instance
  static final StorageServices _storageServices = StorageServices.instance;

  static Future<bool?> givingRatings(
      String sellerId, String rating, String review) async {
    try {
      String token = _storageServices.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.rating,
        body: {
          "sellerId": sellerId,
          "rating": rating,
          "review": review,
        },
        header: {"Authorization": token},
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // UPDATED METHODS FOR REVIEWED ORDERS
  // Save reviewed orders as comma-separated string
  static Future<void> saveReviewedOrders(String reviewedOrders) async {
    try {
      await _storageServices.saveReviewedOrders(reviewedOrders);
    } catch (e) {
      appLog('Error saving reviewed orders: $e');
    }
  }

  // Get reviewed orders string
  static String? getReviewedOrders() {
    try {
      return _storageServices.getReviewedOrders();
    } catch (e) {
      appLog('Error getting reviewed orders: $e');
      return null;
    }
  }

  // Clear reviewed orders (optional - for testing or user logout)
  static Future<void> clearReviewedOrders() async {
    try {
      await _storageServices.clearReviewedOrders();
    } catch (e) {
      appLog('Error clearing reviewed orders: $e');
    }
  }
}