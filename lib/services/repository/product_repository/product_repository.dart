import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_product_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/models/all_product_model.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/models/search_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';

class ProductRepository {
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

  static Future<CategoryAllModel?> fetchAllCategories() async {
    try {
      var isActive = true;
      var response = await ApiServices.instance.apiGetServices(
          "${ApiUrls.instance.categories}$isActive",
          statusCode: 200);
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

  

  static Future<CategoryProductModel?> fetchCategoryProducts(
    String categoryName,
  ) async {
    try {
      var response = await ApiServices.instance.apiGetServices(
          "${ApiUrls.instance.allProducts}?categoryName=$categoryName");
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
  static Future<SearchProductModel?> fetchSearchProducts (String searchQuery) async{
    try{
      var response = await ApiServices.instance.apiGetServices(
          "${ApiUrls.instance.allProducts}?searchTerm=$searchQuery");
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
}
