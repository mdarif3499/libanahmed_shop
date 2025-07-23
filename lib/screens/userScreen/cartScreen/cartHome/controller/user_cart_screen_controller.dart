import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/models/cart_models.dart';
import 'package:ahmed_shop/services/repository/cart_repository/cart_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<Result> cartList = <Result>[].obs;
  RxBool isLoading = true.obs;
  // Track loading state for each product by productId
  RxMap<String, bool> productQuantityLoading = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartProduct();
  }

  @override
  void onReady() {
    super.onReady();
    // This will run every time the screen becomes active
    fetchCartProduct();
  }

  double get totalCost {
    double total = 0.0;
    for (var item in cartList) {
      total += (item.price ?? 0);
    }
    return total;
  }

  void fetchCartProduct() async {
    try {
      isLoading(true);
      final response = await CartRepository.fetchAllCartProduct();
      if (response != null && response.data?.result != null) {
        cartList.assignAll(response.data!.result!);
      } else {
        appLog("No cart products found or response is null");
      }
    } catch (e) {
      appLog("Error fetching cart products: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchCartProductForIncrement() async {
    try {
      // isLoading(true);
      final response = await CartRepository.fetchAllCartProduct();
      if (response != null && response.data?.result != null) {
        cartList.assignAll(response.data!.result!);
      } else {
        appLog("No cart products found or response is null");
      }
    } catch (e) {
      appLog("Error fetching cart products: $e");
    } finally {
      // isLoading(false);
    }
  }

  void productQuantity(
    String productId,
    String action, {
    String increment = "increment",
    String decrement = "decrement",
  }) async {
    try {
      // Set loading state for this specific product
      // productQuantityLoading[productId] = true;
      // productQuantityLoading.refresh(); // Notify UI of change
      appLog(
        "Updating product quantity for ID: $productId with action: $action",
      );

      final response = await CartRepository.addingQuantity(productId, action);

      if (response != null && response == true) {
        appLog("Product quantity updated successfully");
        // Refresh the cart to get updated quantities
        fetchCartProductForIncrement();
      } else {
        appLog("Failed to update product quantity");
      }
    } catch (e) {
      appLog("Error updating product quantity: $e");
    } finally {
      // Clear loading state for this specific product
      // productQuantityLoading[productId] = false;
      // productQuantityLoading.refresh(); // Notify UI of change
    }
  }

  void deleteCartProduct(String productId) async {
    try {
      final response = await CartRepository.deleteCartProduct(productId);
      if (response != null && response == true) {
        appLog("Product deleted successfully");
        // Optionally, you can show a success message
        fetchCartProduct();
      } else {
        appLog("Failed to delete product");
      }
    } catch (e) {
      appLog("Error deleting cart product: $e");
    } finally {
      fetchCartProduct();
    }
  }
}
