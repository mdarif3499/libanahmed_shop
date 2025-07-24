import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/orderProgress/models/parcel_tracking_models.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/models/track_order_models.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/viewOrder/model/view_order_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';

class OrderRepository {
  static Future<bool?> createOrder({
    required String postalCode,
    required String phoneNumber,
    required String stateCode,
    required String cityName,
    required String countryCode,
    required String addressLine1,
    required String addressLine2,
  }) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: ApiUrls.instance.createOrder,
        body: {
          "postal_code": postalCode,
          "phone_number": phoneNumber,
          "state_code": stateCode,
          "city": cityName,
          "country_code": countryCode,
          "address_line1": addressLine1,
          "address_line2": addressLine2,
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
    try {
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
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> deleteOrder(String orderId) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiDeleteServices(
        url: "${ApiUrls.instance.deleteOrder}$orderId",
        statusCode: 200,
        query: {"Authorization": token},
      );
      if (response != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> addShipingCharge(String orderId) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiPostServices(
        url: "${ApiUrls.instance.addShipingCharge}/$orderId",
        query: {"Authorization": token},
      );
      if (response != null) {
        // Parse the shipping rate information from the response
        if (response.containsKey('data') &&
            response['data'].containsKey('RateResponse') &&
            response['data']['RateResponse'].containsKey('RatedShipment')) {
          var ratedShipment = response['data']['RateResponse']['RatedShipment'];

          // Extract the required information
          var billingWeight = ratedShipment['BillingWeight']['Weight'];
          var transportationCharges =
              ratedShipment['TransportationCharges']['MonetaryValue'];
          var serviceOptionsCharges =
              ratedShipment['ServiceOptionsCharges']['MonetaryValue'];
          var totalCharges = ratedShipment['TotalCharges']['MonetaryValue'];

          return {
            'billingWeight': billingWeight,
            'transportationCharges': transportationCharges,
            'serviceOptionsCharges': serviceOptionsCharges,
            'totalCharges': totalCharges,
          };
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<ParcelDeliveryTrackingModel?> trackingOrder(String trackingNumber) async {
    try{
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.trackingOrder}$trackingNumber",
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return ParcelDeliveryTrackingModel.fromJson(response);
      }
    }catch(e){
      return null;
    }
    return null;
  }
}
