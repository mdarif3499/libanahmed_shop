import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/models/track_order_models.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/viewOrder/model/view_order_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:flutter/cupertino.dart';

class OrderRepository {
  static Future<bool?> createOrder({
    required String zipCode,
    required String streetName,
    required String stateCode,
    required String phoneNumber,
    required String locality,
    required String houseNumnber,
    required String country,
    required String address,
  }) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.createOrder,
        body: {
          "zip_code": zipCode,
          "street_name": streetName,
          "state_code": stateCode,
          "phone_number": phoneNumber,
          "locality": locality,
          "house_number": houseNumnber,
          "country": country,
          "address": address
        },
        header: {"Authorization": token},
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<TrackOrderModel?> fetchAllOrder(String action) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.trackOrder}$action",
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return TrackOrderModel.fromJson(response);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  static Future<ViewOrderModel?> showSingleOrder(String orderId) async {
    try{
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.viewOrder}$orderId",
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return ViewOrderModel.fromJson(response);
      }
      return null;
    }catch(e){
      return null;
    }
  }
  static Future<bool?> deleteOrder(String orderId)async{
    try{
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiDeleteServices(url: "${ApiUrls.instance.deleteOrder}$orderId",statusCode: 200,query : {"Authorization": token});
      if (response != null) {
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }
}
