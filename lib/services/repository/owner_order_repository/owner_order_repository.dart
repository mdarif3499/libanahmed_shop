import 'package:ahmed_shop/constant/app_api_end_point.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/models/owner_order_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuBestSelling/models/owner_menu_best_selling_items_model.dart';
import 'package:ahmed_shop/services/api/api_services.dart';

import '../../storage_services/storage_services.dart';

class OwnerOrderRepository {
  //! Owner Order Repository
  static Future<OwnerOrderModel?> fetchAlltheOwnerOrders(String action) async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        "${ApiUrls.instance.ownerOrder}$action",
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return OwnerOrderModel.fromJson(response);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<OwnerBestSellingProductModel?> fetchBestSellingItem() async {
    try {
      String token = StorageServices.instance.getToken();
      var response = await ApiServices.instance.apiGetServices(
        ApiUrls.instance.ownerBestSellingItem,
        statusCode: 200,
        headers: {"Authorization": token},
      );
      if (response != null) {
        return OwnerBestSellingProductModel.fromJson(response);
      }
      return null;

    }catch (e) {
      return null;
    } 
  }
}
