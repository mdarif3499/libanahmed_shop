import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/models/user_profile_model.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/models/user_profile_settings_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  static Future<ProfileGetModel?> fetchUserProfile() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
          ApiUrls.instance.userProfile,
          statusCode: 200,
          queryParameters: {"Authorization": token});
      if (response != null) {
        return ProfileGetModel.fromJson(response);
      } else {
        appLog('Failed to load user profile');
        return null;
      }
    } catch (e) {
      appLog('Error fetching user profile: $e');
      return null;
    }
  }

  static Future<bool?> updateUserProfile({
    required String fullName,
    required String phone,
    required String address,
    required String image,
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
          "address": address,
          "image": image
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


  static Future<UserProfileSettingsModel?> fetchSettings() async {
    try {
      var response = await ApiServices.instance
          .apiGetServices(ApiUrls.instance.userProfileSettings);
      if (response != null) {
        return UserProfileSettingsModel.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
