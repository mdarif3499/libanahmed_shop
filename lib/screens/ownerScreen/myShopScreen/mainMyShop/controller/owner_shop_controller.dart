import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_categroy_model.dart'
    as OwnerAllCategoryModel;
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_product_mode.dart'
    as OwnerAllProductModel;
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_overview_checking_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class OwnerShopController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isCategory = true.obs;
  RxBool isProduct = true.obs;
  RxBool isCategoryProductLoading = false.obs;
  RxBool isCategoryProductShowing = false.obs;
  RxBool isOwnerOverviewCheckLoading = false.obs;
  var productList = <OwnerAllProductModel.Datum>[].obs;
  var categoryList = <OwnerAllCategoryModel.Datum>[].obs;
  // Changed to use the same product model type
  var categoryProductList = <OwnerAllProductModel.Datum>[].obs;
  var ownerOverviewCheckList = Rxn<OwnerOverviewCheckingModel>();

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchAllCategories();
    ownerOverViewCheck();
  }

  void fetchAllProducts() async {
    try {
      isProduct(true);
      var products = await OwnerProductRepository.fetchAllProduct();
      if (products != null && products.data != null) {
        productList.assignAll(products.data!);
      } else {
        productList.clear();
      }
    } catch (e) {
      appLog('Error fetching products: $e');
      productList.clear();
    } finally {
      isProduct(false);
      updateAllLoadingState();
    }
  }

  void fetchAllCategories() async {
    try {
      isCategory(true);
      var categories = await OwnerProductRepository.fetchAllCategories();
      if (categories != null && categories.data != null) {
        categoryList.assignAll(categories.data!);
      } else {
        categoryList.clear();
      }
    } catch (e) {
      appLog('Error fetching categories: $e');
      categoryList.clear();
    } finally {
      isCategory(false);
      updateAllLoadingState();
    }
  }

  void showCategoryProducts(String categoryName) async {
    try {
      isCategoryProductLoading(true);
      isCategoryProductShowing(true);

      // Clear previous category products
      categoryProductList.clear();

      // Hit the API to fetch products for this category
      var categoryProducts = await OwnerProductRepository.fetchCategoryProducts(
        categoryName,
      );
      if (categoryProducts != null && categoryProducts.data != null) {
        categoryProductList.assignAll(categoryProducts.data!);
        appLog(
          'Fetched ${categoryProducts.data!.length} products for category: $categoryName',
        );
      } else {
        categoryProductList.clear();
        appLog('No products found for category: $categoryName');
      }
    } catch (e) {
      appLog('Error fetching category products: $e');
      categoryProductList.clear();
    } finally {
      isCategoryProductLoading(false);
    }
  }

  void ownerOverViewCheck() async {
    try {
      isOwnerOverviewCheckLoading(true);
      appLog('Starting owner overview check...');

      var result = await OwnerProductRepository.fetchOverView();
      if (result != null) {
        ownerOverviewCheckList.value = result;
        appLog('Overview check completed successfully');
        appLog('Profile Update: ${result.data?.profileUpdate}');
        appLog('Shop Create Verify: ${result.data?.shopCreateVarify}');
        appLog('Stripe Connected: ${result.data?.stripeConnectedAccount}');

        // Check if fully setup
        final isFullySetup =
            (result.data?.profileUpdate ?? false) &&
            (result.data?.shopCreateVarify ?? false) &&
            (result.data?.stripeConnectedAccount ?? false);
        appLog('Is Fully Setup: $isFullySetup');
      } else {
        ownerOverviewCheckList.value = null;
        appLog('Overview check returned null');
      }
    } catch (e) {
      appLog('Error fetching owner overview: $e');
      ownerOverviewCheckList.value = null;
    } finally {
      isOwnerOverviewCheckLoading(false);
    }
  }

  void showAllProducts() {
    isCategoryProductShowing.value = false;
    isCategoryProductLoading.value = false;
  }

  void updateAllLoadingState() {
    isLoading.value = isCategory.value || isProduct.value;
  }

  void refreshData() {
    fetchAllProducts();
    fetchAllCategories();
    ownerOverViewCheck();
  }
}
