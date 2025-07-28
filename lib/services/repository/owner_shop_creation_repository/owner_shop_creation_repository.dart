import 'dart:io';

import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:dio/dio.dart'; // Import dio for FormData and MultipartFile

class OwnerShopCreationRepository {
  static Future<bool?> shopCreation(
    String name,
    String address,
    String description,
    List<File> images,
    List<File> documents, // List of document images
  ) async {
    try {
      // Validate inputs
      if (name.trim().isEmpty) {
        appLog("Shop name is required");
        return false;
      }
      if (address.trim().isEmpty) {
        appLog("Shop address is required");
        return false;
      }
      if (description.trim().isEmpty) {
        appLog("Shop description is required");
        return false;
      }
      if (images.isEmpty) {
        appLog("At least one shop image is required");
        return false;
      }
      if (documents.isEmpty) {
        appLog("At least one document is required");
        return false;
      }

      String token = StorageServices.instance.getToken();
      appLog("Token: $token");

      // Create FormData for multipart file upload
      FormData formData = FormData();

      // Add text fields
      formData.fields.add(MapEntry("name", name.trim()));
      formData.fields.add(MapEntry("address", address.trim()));
      formData.fields.add(MapEntry("description", description.trim()));

      // Add image files
      for (int i = 0; i < images.length; i++) {
        File imageFile = images[i];
        if (await imageFile.exists()) {
          String fileName = imageFile.path.split('/').last;
          appLog("Adding image: $fileName");

          formData.files.add(
            MapEntry(
              "image",
              await MultipartFile.fromFile(imageFile.path, filename: fileName),
            ),
          );
        } else {
          appLog("Image file does not exist: ${imageFile.path}");
        }
      }

      // Add document files
      for (int i = 0; i < documents.length; i++) {
        File documentFile = documents[i];
        if (await documentFile.exists()) {
          String fileName = documentFile.path.split('/').last;
          appLog("Adding document: $fileName");

          formData.files.add(
            MapEntry(
              "document",
              await MultipartFile.fromFile(
                documentFile.path,
                filename: fileName,
              ),
            ),
          );
        } else {
          appLog("Document file does not exist: ${documentFile.path}");
        }
      }

      appLog("FormData fields: ${formData.fields}");
      appLog("FormData files count: ${formData.files.length}");

      appLog("Making API call to: ${ApiUrls.instance.ownerShopCreation}");

      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.ownerShopCreation,
        body: formData,
        header: {
          "Authorization": token,
          // Don't set Content-Type for multipart/form-data, let Dio handle it
        },
      );

      appLog("Shop creation response: $response");

      if (response != null) {
        appLog("Shop creation successful");
        return true;
      } else {
        appLog("Shop creation failed - null response");
        return false;
      }
    } catch (e) {
      appLog("Error in shop creation: $e");
      return false;
    }
  }
}
