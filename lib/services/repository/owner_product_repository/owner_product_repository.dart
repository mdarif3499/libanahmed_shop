import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_categroy_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_product_mode.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';

class OwnerProductRepository {
  //! Fetch All the Product
  static Future<OwnerAllProductModel?> fetchAllProduct() async {
    try {
      var response = await ApiServices.instance
          .apiGetServices(ApiUrls.instance.ownerAllProducts);
      if (response != null) {
        return OwnerAllProductModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //! Fetch All Category Model
  static Future<OwnerAllCategoryModel?> fetchAllCategories() async {
    try {
      var isActive = true;
      var response = await ApiServices.instance.apiGetServices(
          "${ApiUrls.instance.categories}$isActive",
          statusCode: 200);
      if (response != null) {
        return OwnerAllCategoryModel.fromJson(response);
      } else {
        appLog('Failed to load categories: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching categories: $e");
      return null;
    }
  }

  //! Fetch Category Products - Fixed to return OwnerAllProductModel
  static Future<OwnerAllProductModel?> fetchCategoryProducts(
    String categoryName,
  ) async {
    try {
      var response = await ApiServices.instance.apiGetServices(
          "${ApiUrls.instance.ownerAllProduct}?categoryName=$categoryName");
      if (response != null) {
        return OwnerAllProductModel.fromJson(
            response); // Changed to return product model
      } else {
        appLog('Failed to load category products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching category products: $e");
      return null;
    }
  }
}
