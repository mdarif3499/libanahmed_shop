import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/models/category_product_models.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/models/all_product_model.dart';
import 'package:ahmed_shop/services/repository/cart_repository/cart_repository.dart';
import 'package:ahmed_shop/services/repository/product_repository/product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isProductLoading = true.obs;
  RxBool isCategoryLoading = true.obs;
  RxBool isCategoryProductLoading = true.obs;
  RxBool isAddToCart = false.obs;
  RxBool isCategoryProductShowing = false.obs;
  final Rxn<ProductAllModel> productList = Rxn<ProductAllModel>();
  final Rxn<CategoryAllModel> categoryList = Rxn<CategoryAllModel>();
  final Rxn<CategoryProductModel> categoryProductList =
      Rxn<CategoryProductModel>();
  // var productList = <ProductModel.Datum>[].obs;
  // var categoryList = <CategoryModel.Datum>[].obs;
  // var categoryProductList = <CategoryProductModel.Datum>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchAllCategories();
  }

  void fetchAllProducts() async {
    try {
      isProductLoading(true);
      var products = await ProductRepository.fetchAllProducts();
      if (products != null && products.data != null) {
        productList.value = products;
      } else {
        productList.value = ProductAllModel();
      }
    } catch (e) {
      appLog('Error fetching products: $e');
      productList.value = ProductAllModel();
    } finally {
      isProductLoading(false);
      _updateOverallLoadingState();
    }
  }

  void fetchAllCategories() async {
    try {
      isCategoryLoading(true);
      var categories = await ProductRepository.fetchAllCategories();
      if (categories != null && categories.data != null) {
        categoryList.value = categories;
      } else {
        categoryList.value = CategoryAllModel();
      }
    } catch (e) {
      appLog('Error fetching categories: $e');
      categoryList.value = CategoryAllModel();
    } finally {
      isCategoryLoading(false);
      _updateOverallLoadingState();
    }
  }

  void addtocart({required String productId}) async {
    try {
      isAddToCart(true);
      bool? isAdded = await CartRepository.addToCart(productId: productId);
      if (isAdded == true) {
        appLog('Product added to cart successfully');
        AppSnackBar.message('Product added to cart successfully');
      } else {
        appLog('Failed to add product to cart');
        AppSnackBar.error('Failed to add product to cart');
      }
    } catch (e) {
      appLog('Error adding to cart: $e');
      AppSnackBar.error('Error adding to cart: $e');
    } finally {
      isAddToCart(false);
    }
  }

  void showCategoryProducts(String categoryName) async {
    try {
      isCategoryProductLoading(true);
      isCategoryProductShowing(
        true,
      ); // Set to true when showing category products
      var categoryProducts = await ProductRepository.fetchCategoryProducts(
        categoryName,
      );
      if (categoryProducts != null && categoryProducts.data != null) {
        categoryProductList.value = categoryProducts;
      } else {
        categoryProductList.value = CategoryProductModel();
      }
    } catch (e) {
      appLog('Error fetching category products: $e');
      categoryProductList.value = CategoryProductModel();
    } finally {
      isCategoryProductLoading(false);
      _updateOverallLoadingState();
    }
  }

  // Add method to reset to show all products
  void showAllProducts() {
    isCategoryProductShowing(false);
  }

  void _updateOverallLoadingState() {
    isLoading.value =
        isProductLoading.value ||
        isCategoryLoading.value ||
        isCategoryProductLoading.value;
  }

  // Method to refresh data
  void refreshData() {
    fetchAllProducts();
    fetchAllCategories();
  }
}
