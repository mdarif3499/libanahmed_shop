import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/models/cart_models.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:dio/dio.dart';

class CartRepository {
  static Future<bool?> addToCart({required String productId}) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.addToCart,
        body: {"productId": productId},
        header: {"Authorization": token},
      );
      if (response != null) return true;
      return false;
    } catch (e) {
      appLog("message: $e");
      return false;
    }
  }

  static Future<CartAllProductModel?> fetchAllCartProduct() async {
    try {
      String token = StorageServices.instance.getToken();
      appLog(
          "Fetching cart with token: ${token.isNotEmpty ? 'Present' : 'Missing'}");

      final response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.cartProduct,
        statusCode: 200,
        headers: {"Authorization": "Bearer $token"},
      );

      appLog("Cart API response: $response");

      if (response != null) {
        final cartModel = CartAllProductModel.fromJson(response);
        appLog(
            "Parsed cart model - Items count: ${cartModel.data?.result?.length ?? 0}");
        return cartModel;
      } else {
        appLog('Failed to load cart products: response is null');
        return null;
      }
    } catch (e) {
      appLog("Error in Fetching the Cart Product: $e");
      return null;
    }
  }

  static Future<bool?> addingQuantity(String productId, String action) async {
    try {
      String token = StorageServices.instance.getToken();
      appLog(
          "Fetching cart with token: ${token.isNotEmpty ? 'Present' : 'Missing'}");

      final response = await ApiServices.instance.apiPatchServices(
        url: "${ApiUrls.instance.cartProduct}/$productId/quantity/$action",
        statusCode: 200,
        options: Options(headers: {"Authorization": token}),
      );
      if (response != null) {
        return true;
      } else {
        appLog('Failed to load products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error in Fetching the Cart Product : $e");
      return null;
    }
  }

  static Future<bool?> deleteCartProduct(String productId) async {
    try {
      String token = StorageServices.instance.getToken();
      appLog(
          "Fetching cart with token: ${token.isNotEmpty ? 'Present' : 'Missing'}");
    final response = await ApiServices.instance.apiDeleteServices(url: "${ApiUrls.instance.cartProduct}/$productId");
      if (response != null) {
        appLog("Product deleted successfully");
        return true;
      } else {
        appLog('Failed to delete product: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      appLog("Error in deleting the Cart Product: $e");
      return false;
    }
  }
}
