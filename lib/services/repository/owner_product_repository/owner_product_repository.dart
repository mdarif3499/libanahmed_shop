import 'dart:io';

import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_categroy_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_product_mode.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class OwnerProductRepository {
  //! Fetch All the Product
  static Future<OwnerAllProductModel?> fetchAllProduct() async {
    try {
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.ownerAllProducts,
      );
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
        statusCode: 200,
      );
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
        "${ApiUrls.instance.ownerAllProduct}?categoryName=$categoryName",
      );
      if (response != null) {
        return OwnerAllProductModel.fromJson(
          response,
        ); // Changed to return product model
      } else {
        appLog('Failed to load category products: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      appLog("Error fetching category products: $e");
      return null;
    }
  }

  //! Owner Create Product
  static Future<bool?> ownerCreateProduct(
    String name,
    String descrition,
    String price,
    String stock,
     List<File> images,
    String weight,
    String categoryId,
  ) async {
    try {
      String token = StorageServices.instance.getToken();
      dio.FormData formData = dio.FormData.fromMap({
        "name": name,
          "details": descrition,
          "price": price,
          "stock": stock,
          "images": await Future.wait(
          images.map((file) => dio.MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          )).toList(),
        ),
          "weight": weight,
          "categoryId": categoryId,
      });
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerProductCreate,
        body: formData,
        header: {"Authorization": token,
        "Content-Type": "multipart/form-data",},
      );
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
