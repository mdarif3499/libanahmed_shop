import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_product_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/models/all_product_model.dart';
import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/models/product_details_model.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/models/search_model.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuFavourite/models/user_menu_favourite_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';

class ProductRepository {
  //! Fetch All The Products
  static Future<ProductAllModel?> fetchAllProducts() async {
    try {
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.allProducts,
        statusCode: 200,
      );
      if (response != null) {
        return ProductAllModel.fromJson(response);
      } else {
        appLog('Failed to load products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog('Error fetching products: $e');
      return null;
    }
  }

  //! Fetch All the Category
  static Future<CategoryAllModel?> fetchAllCategories() async {
    try {
      var isActive = true;
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.categories}$isActive",
        statusCode: 200,
      );
      if (response != null) {
        return CategoryAllModel.fromJson(response);
      } else {
        appLog('Failed to load categories: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching categories: $e");
      return null;
    }
  }

  //! Fetch Category Products
  static Future<CategoryProductModel?> fetchCategoryProducts(
    String categoryName,
  ) async {
    try {
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.allProducts}?categoryName=$categoryName",
      );
      if (response != null) {
        return CategoryProductModel.fromJson(response);
      } else {
        appLog('Failed to load category products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching category products: $e");
      return null;
    }
  }

  //! Find the All the fetch Search Products
  static Future<SearchProductModel?> fetchSearchProducts(
    String searchQuery,
  ) async {
    try {
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.allProducts}?searchTerm=$searchQuery",
      );
      if (response != null) {
        return SearchProductModel.fromJson(response);
      } else {
        appLog('Failed to load search products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching search products: $e");
      return null;
    }
  }

  //! Fetch the Single Product Details
  static Future<SingleProductDetailsModel?> fetchSingleProductDetails(
    String productId,
  ) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.allProducts}/$productId",
        statusCode: 200,
        headers: {"Authorization": "Bearer $token"},
      );
      if (response != null) {
        return SingleProductDetailsModel.fromJson(response);
      } else {
        appLog('Failed to load single product details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching single product details: $e");
      return null;
    }
  }

  //! Add to Favourite
  static Future<bool?> addFavourite(String productId) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.favouriteProduct,
        body: {"productId": productId},
        header: {"Authorization": token},
      );
      if (response != null) {
        return true;
      } else {
        appLog('Failed to add to favorites: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error adding to favorites: $e");
      return null;
    }
  }

  //! Fetch All the Favourite Products
  static Future<UserMenuFavouriteModel?> fetchAllFavouriteProducts() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.favouriteProduct,
        statusCode: 200,
        headers: {"Authorization": "Bearer $token"},
      );
      if (response != null) {
        return UserMenuFavouriteModel.fromJson(response);
      } else {
        appLog('Failed to load favourite products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching all favourite products: $e");
      return null;
    }
  }
}
