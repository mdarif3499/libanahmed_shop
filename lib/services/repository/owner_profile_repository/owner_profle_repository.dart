import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/model/profile_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/profileHome/model/profile_setting_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:dio/dio.dart';

class OwnerProfleRepository {
  static Future<OwnerProfileSettingsModel?> fetchSettings() async {
    try {
      var response = await ApiServices.instance
          .apiGetServices(ApiUrls.instance.ownerProfileSettings);
      if (response != null) {
        return OwnerProfileSettingsModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
  static Future<OwnerProfileModel?> fetchProfile () async {
    try {
      var response = await ApiServices.instance
          .apiGetServices(ApiUrls.instance.ownerProfile);
      if (response != null) {
        return OwnerProfileModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> updateOwnerProfile({
    required String fullName,
    required String phone,
    required String image,
    required String addressLine1,
    required String addressLine2,
    required String city,
    required String stateCode,
    required String countryCode,
    required String postalCode,
   
  }) async {
    try {
      String token = StorageServices.instance.getToken();

      // Create options with extended timeout for image upload
      Options options = Options(
        headers: {"Authorization": token},
        sendTimeout: Duration(seconds: 60), // 60 seconds for sending
        receiveTimeout: Duration(seconds: 60), // 60 seconds for receiving
      );

      var response = await ApiServices.instance.apiPatchServices(
        url: ApiUrls.instance.userProfileUpdate,
        body: {
          "fullName": fullName,
          "phone": phone,
          "image": image,
          "address_line1" : addressLine1,
          "address_line2" : addressLine2,
          "city" : city,
          "state_code" : stateCode,
          "country_code" : countryCode,
          "postal_code" : postalCode
        },
        statusCode: 200,
        options: options,
      );

      if (response != null) {
        return true;
      } else {
        appLog('Failed to update user profile');
        return false;
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.sendTimeout ||
          dioError.type == DioExceptionType.receiveTimeout ||
          dioError.type == DioExceptionType.connectionTimeout) {
        appLog('Timeout error updating user profile: ${dioError.message}');
        throw Exception('Connection timeout. Please try again.');
      } else {
        appLog('Dio error updating user profile: ${dioError.message}');
        return false;
      }
    } catch (e) {
      appLog('Error updating user profile: $e');
      return false;
    }
  }
}
