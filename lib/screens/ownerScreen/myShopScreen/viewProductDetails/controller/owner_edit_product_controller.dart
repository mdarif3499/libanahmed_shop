import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/models/owner_view_product_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerEditProductController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDelete = false.obs;
  var productID = ''.obs;
  var singleProductDetails = Rxn<OwnerSingleProductModel>();
  final arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    // Retrieve product ID from arguments
    if (arguments != null && arguments['id'] != null) {
      productID.value = arguments['id'];
      loadProductData(productID.value);
    }
  }

  void loadProductData(String productID) async {
    try {
      isLoading(true);
      final result = await OwnerProductRepository.fetchSingleProductDetails(
        productID,
      );
      if (result != null) {
        singleProductDetails.value = result;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load product details: $e');
    } finally {
      isLoading(false);
    }
  }

  void deleteProduct(String productId) async {
    try {
      isLoadingDelete(true);
      final result = await OwnerProductRepository.deleteProduct(productId);
      if (result == true) {
        appLog("Product deleted successfully");
        Get.snackbar('Success', 'Product deleted successfully');
        Get.offAllNamed('/ownerProductList'); // Replace with your actual route
      }
    } catch (e) {
      appLog("Error deleting product: $e");
      Get.snackbar('Error', 'Failed to delete product: $e');
    } finally {
      isLoadingDelete(false);
    }
  }
}
