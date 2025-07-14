import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/models/owner_view_product_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:get/get.dart';

class OwnerEditProductController extends GetxController {
  var isLoading = false.obs;
  var productID = ''.obs;
  var singleProductDetails = Rxn<OwnerSingleProductModel>();
  final arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    loadProductData(productID.value);
  }

  void loadProductData(String productID) {
    try {
      isLoading(true);
      final result = OwnerProductRepository.fetchSingleProductDetails(
        productID
      );
      result.then((value) {
        if (value != null) {
          singleProductDetails.value = value;
        }
        isLoading(false);
      });
    } catch (e) {
      isLoading(false);
    }
  }
}
