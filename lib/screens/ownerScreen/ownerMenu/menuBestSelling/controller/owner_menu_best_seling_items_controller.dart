import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuBestSelling/models/owner_menu_best_selling_items_model.dart';
import 'package:ahmed_shop/services/repository/owner_order_repository/owner_order_repository.dart';
import 'package:get/get.dart';

class OwnerMenuBestSelingItemsController extends GetxController {
  var isLoading = false.obs;
  var bestSellingItems = Rxn<OwnerBestSellingProductModel>();

  @override
  void onInit() {
    super.onInit();
    fetchBestSellingItem();
  }

  void fetchBestSellingItem() async {
    try{
      isLoading(true);
      var response = await OwnerOrderRepository.fetchBestSellingItem();
      if(response != null){
        bestSellingItems.value = response;
      }
      isLoading(false);
    }
    catch(e){
      isLoading(false);
    }
  }
}
