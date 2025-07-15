import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuOffer/models/create_offer_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_log.dart';

class OwnerCreateOfferController extends GetxController {
  var isLoading = false.obs;

  var offerProductList = Rxn<CreateOfferModel>();

  @override
  void onInit() {
    super.onInit();
    fetchOfferProductList();
  }

  void fetchOfferProductList() async {
    try {
      isLoading(true);
      var result = await OwnerProductRepository.fetchCreateOffer();
      if (result != null) {
        offerProductList.value = result;
      }
      isLoading(false);
    } catch (e) {
      appLog("Error fetching category products: $e");
    }
  }
}
