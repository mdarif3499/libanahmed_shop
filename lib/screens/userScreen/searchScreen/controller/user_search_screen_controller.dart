import 'dart:async';
import 'package:ahmed_shop/screens/userScreen/searchScreen/models/search_model.dart';
import 'package:ahmed_shop/services/repository/cart_repository/cart_repository.dart';
import 'package:ahmed_shop/services/repository/product_repository/product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSearchScreenController extends GetxController {
  var searchController = TextEditingController();
  var searchResults = <Datum>[].obs;
  var isLoading = false.obs;
  var isAddToCart = false.obs; // Reactive variable for add to cart state

  Timer? _debounceTimer;

  void onSearchChanged(String query) {
    searchController.text = query;

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    // If the query is empty, clear results and stop loading
    if (query.trim().isEmpty) {
      searchResults.clear();
      isLoading.value = false;
      return;
    }
    // Set up new timer with 800ms delay (you can adjust this)
    _debounceTimer = Timer(Duration(milliseconds: 800), () {
      searchProducts(query);
    });
  }

  void searchProducts(String query) async {
    try {
      isLoading.value = true;
      searchController.text = query;
      var results = await ProductRepository.fetchSearchProducts(query);
      if (results != null && results.data != null) {
        searchResults.assignAll(results.data!);
      } else {
        searchResults.clear();
      }
    } catch (e) {
      searchResults.clear();
      appLog('Error searching products: $e');
    } finally {
      isLoading.value = false;
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

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.onClose();
  }
}
