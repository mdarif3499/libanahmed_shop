import 'dart:async';
import 'dart:io';

import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/api/api.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/error_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiServices {
  ///////////////
  ApiServices._privateConstructor();

  static final ApiServices _instance = ApiServices._privateConstructor();

  static ApiServices get instance => _instance;

  //////////  object
  final api = AppApi();
  var storageServices = StorageServices.instance;

  Future<dynamic> apiPutServices(
      {required String url,
      dynamic body,
      int statusCode = 200,
      Map<String, dynamic>? query}) async {
    try {
      final response =
          await api.sendRequest.put(url, data: body, queryParameters: query);
      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.onboardScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          AppSnackBar.error("${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiPostServices(
      {required String url,
      dynamic body,
      int statusCodeStart = 200,
      int statusCodeEnd = 299,
      Map<String, dynamic>? query,
      dynamic header}) async {
    try {
      final dynamic response = await AppApi().sendRequest.post(
            url,
            data: body,
            options: header != null ? Options(headers: header) : null,
          );
      if (response.statusCode >= statusCodeStart &&
          response.statusCode <= statusCodeEnd) {
        return response.data;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.onboardScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          AppSnackBar.error("${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiGetServices(String url,
    {int statusCode = 200,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,  // Add headers parameter
    dynamic body}) async {
  try {
    final response = await api.sendRequest.get(
      url, 
      queryParameters: queryParameters, 
      data: body,
      options: Options(headers: headers),  // Pass headers to the request
    );
    if (response.statusCode == statusCode) {
      return response.data;
    } else {
      return null;
    }
  } on SocketException catch (e) {
    errorLog('api socket exception', e);
    AppSnackBar.error("Check Your Internet Connection");
    return null;
  } on TimeoutException catch (e) {
    errorLog('api time out exception', e);
    return null;
  } on DioException catch (e) {
    if (e.response.runtimeType != Null) {
      if (e.response?.statusCode == 401) {
        await storageServices.storageClear();
        Get.offAllNamed(AppRoutes.onboardScreen);
      }

      if (e.response?.data["message"].runtimeType != Null) {
        AppSnackBar.error("${e.response?.data["message"]}");
      }

      return null;
    }
    errorLog('api dio exception', e);
    return null;
  } catch (e) {
    errorLog('api exception', e);
    return null;
  }
}
  Future<dynamic> apiPatchServices(
      {required String url,
      Object? body,
      int statusCode = 200,
      Map<String, dynamic>? query,
      Options? options}) async {
    try {
      final response = await api.sendRequest
          .patch(url, data: body, queryParameters: query, options: options);

      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        AppSnackBar.error(
            "Unexpected response: ${response.statusCode} ${response.statusMessage}");
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.onboardScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          AppSnackBar.error("${e.response?.data["message"]}");
        }
        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiDeleteServices(
      {required String url,
      Object? body,
      int statusCode = 200,
      Map<String, dynamic>? query,
      Options? options}) async {
    try {
      final response = await api.sendRequest
          .delete(url, data: body, queryParameters: query, options: options);

      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        AppSnackBar.error(
            "Unexpected response: ${response.statusCode} ${response.statusMessage}");
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      AppSnackBar.error("Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.onboardScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          AppSnackBar.error("${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }
}
