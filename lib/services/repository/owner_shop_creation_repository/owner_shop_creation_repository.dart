import 'dart:io';
import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:dio/dio.dart'; // Import dio for FormData and MultipartFile

class OwnerShopCreationRepository {
  static Future<bool?> shopCreation(
    String name,
    String description,
    List<File> images, // List of store images
    List<File> documents, // List of document images
  ) async {
    try {
      String token = StorageServices.instance.getToken();

      // Create FormData for multipart file upload
      FormData formData = FormData.fromMap({
        "name": name,
        "description": description,
        "image": await Future.wait(
          images.map((file) => MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          )).toList(),
        ),
        "document": await Future.wait(
          documents.map((file) => MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          )).toList(),
        ),
      });

      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerShopCreation,
        body: formData,
        header: {
          "Authorization": token,
          "Content-Type": "multipart/form-data",
        },
      );

      if (response != null) return true;
      return false;
    } catch (e) {
      appLog("Error in shop creation: $e");
      return false;
    }
  }
}