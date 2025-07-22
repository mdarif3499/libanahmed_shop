import 'dart:io';

import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_categroy_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_product_mode.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/models/owner_view_product_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuOffer/models/create_offer_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/error_log.dart';
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

  //! Fetch Category Products
  static Future<OwnerAllProductModel?> fetchCategoryProducts(
    String categoryName,
  ) async {
    try {
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.ownerAllProduct}?categoryName=$categoryName",
      );
      if (response != null) {
        return OwnerAllProductModel.fromJson(response);
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
    String height,
    String width,
    String length,
  ) async {
    try {
      String token = StorageServices.instance.getToken();
      dio.FormData formData = dio.FormData.fromMap({
        "name": name,
        "details": descrition,
        "price": price,
        "stock": stock,
        "images": await Future.wait(
          images
              .map(
                (file) => dio.MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              )
              .toList(),
        ),
        "weight": weight,
        "categoryId": categoryId,
        "height": height,
        "width": width,
        "length": length,
      });
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerProductCreate,
        body: formData,
        header: {"Authorization": token, "Content-Type": "multipart/form-data"},
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

  //! Owner View Product Model
  static Future<OwnerSingleProductModel?> fetchSingleProductDetails(
    String productId,
  ) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.ownerEditProduct}/$productId",
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return OwnerSingleProductModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  //! Delete Product
  static Future<bool?> deleteProduct(String productId) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiDeleteServices(
        url: "${ApiUrls.instance.ownerEditProduct}$productId",
        token: token,
        statusCode: 200,
      );

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      errorLog('deleteProduct exception', e);
      return false;
    }
  }

  //! Edit Product
  static Future<bool?> editProduct(
    String productId,
    String name,
    String description,
    String price,
    String availableStock,
    String weight,
    List<File> images,
  ) async {
    try {
      String token = StorageServices.instance.getToken();

      Map<String, dynamic> formDataMap = {
        "name": name,
        "details": description,
        "price": price,
        "availableStock": availableStock,
        "weight": weight,
      };

      if (images.isNotEmpty) {
        formDataMap["images"] = await Future.wait(
          images
              .map(
                (file) => dio.MultipartFile.fromFile(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              )
              .toList(),
        );
      }

      dio.FormData formData = dio.FormData.fromMap(formDataMap);

      final options = dio.Options(
        headers: {
          "Authorization": token,
          "Content-Type": "multipart/form-data",
        },
      );

      var response = await ApiServices.instance.apiPatchServices(
        url: "${ApiUrls.instance.ownerEditProduct}$productId",
        body: formData,
        options: options,
      );

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      errorLog('editProduct exception', e);
      return false;
    }
  }

  static Future<CreateOfferModel?> fetchCreateOffer() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.ownerCreateOffer,
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null && response is Map<String, dynamic>) {
        return CreateOfferModel.fromJson(response);
      } else {
        appLog('Failed to load offer products: response is null or invalid');
        return null;
      }
    } catch (e) {
      appLog("Error fetching offer products: $e");
      return null;
    }
  }

  static Future<bool?> createOffer(
    String productId,
    String offer,
    String startDate,
    String endDate,
  ) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.offerCreate,
        body: {
          "productId": productId,
          "offer": offer,
          "startDate": startDate,
          "endDate": endDate,
        },
        header: {"Authorization": token},
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
