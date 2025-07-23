import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/models/product_details_model.dart';
import 'package:ahmed_shop/services/repository/product_repository/product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAddingFav = false.obs;
  var singleProductDetails = Rxn<SingleProductDetailsModel>();
  var productId = ''.obs;
  Map<String, dynamic>? arguments;

  // Constructor to accept arguments
  ProductDetailsController({this.arguments});

  @override
  void onInit() {
    // Get arguments from constructor or Get.arguments
    final args = arguments ?? Get.arguments;
    if (args != null && args['id'] != null) {
      productId.value = args['id'];
      getSingleProductDetails(productId.value);
    }
    super.onInit();
  }

  // Method to update product details with new arguments
  void updateProductDetails(Map<String, dynamic> newArguments) {
    if (newArguments['id'] != null) {
      productId.value = newArguments['id'];
      getSingleProductDetails(productId.value);
    }
  }

  void getSingleProductDetails(String productId) async {
    try {
      isLoading(true);
      final result = await ProductRepository.fetchSingleProductDetails(
        productId,
      );
      if (result != null) {
        singleProductDetails.value = result;
      }
    } catch (e) {
      appLog(e);
    } finally {
      isLoading(false);
    }
  }

  //! Add to Favourite
  void addFavourite(String productId) async {
    try {
      isAddingFav(true);
      var response = await ProductRepository.addFavourite(productId);
      if (response != null) {
        update();
        getSingleProductDetails(productId);
      }
    } catch (e) {
      appLog(e);
    } finally {
      isAddingFav(false); // Fixed: was isLoading(false)
    }
  }
}