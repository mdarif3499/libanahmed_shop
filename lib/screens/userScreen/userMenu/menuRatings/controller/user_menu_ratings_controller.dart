import 'package:ahmed_shop/services/repository/settings_repository/setting_repository.dart';
import 'package:ahmed_shop/services/storage_services/storage_services.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserMenuRatingsController extends GetxController {
  RxBool isLoading = false.obs;
  RxDouble currentRating = 3.0.obs;
  var review = TextEditingController().obs;
  RxBool isReviewAlreadyGiven = false.obs;

  String? sellerId;
  String? orderId;

  @override
  void onInit() {
    super.onInit();
  }

  void initializeData(String sellerIdParam, String orderIdParam) {
    sellerId = sellerIdParam;
    orderId = orderIdParam;
    checkIfReviewAlreadyGiven();
  }

  // Check if review is already given for this order and seller combination
  void checkIfReviewAlreadyGiven() {
    if (orderId != null && sellerId != null) {
      List<String> reviewedOrders = getReviewedOrders();
      String orderSellerKey = "${orderId}_${sellerId}";
      isReviewAlreadyGiven.value = reviewedOrders.contains(orderSellerKey);

      appLog("Checking review for: $orderSellerKey");
      appLog("Reviewed orders: $reviewedOrders");
      appLog("Is already reviewed: ${isReviewAlreadyGiven.value}");
    }
  }

  // Get list of reviewed order-seller combinations from storage
  List<String> getReviewedOrders() {
    try {
      String? reviewedOrdersString = SettingRepository.getReviewedOrders();
      if (reviewedOrdersString != null && reviewedOrdersString.isNotEmpty) {
        return reviewedOrdersString.split(',');
      }
      return [];
    } catch (e) {
      appLog('Error getting reviewed orders: $e');
      return [];
    }
  }

  // Save reviewed order-seller combination to storage
  Future<void> saveReviewedOrder(
      String orderIdToSave, String sellerIdToSave) async {
    try {
      List<String> reviewedOrders = getReviewedOrders();
      String orderSellerKey = "${orderIdToSave}_${sellerIdToSave}";

      if (!reviewedOrders.contains(orderSellerKey)) {
        reviewedOrders.add(orderSellerKey);
        String reviewedOrdersString = reviewedOrders.join(',');
        await SettingRepository.saveReviewedOrders(reviewedOrdersString);

        appLog("Saved reviewed order: $orderSellerKey");
        appLog("All reviewed orders: $reviewedOrdersString");
      }
    } catch (e) {
      appLog('Error saving reviewed order: $e');
    }
  }

  // Submit review
  void submitReview() async {
    if (sellerId == null || orderId == null) {
      AppSnackBar.error("Invalid order details.");
      return;
    }

    if (review.value.text.trim().isEmpty) {
      AppSnackBar.error("Please enter a review.");
      return;
    }

    // Double check if review is already given
    if (isReviewAlreadyGiven.value) {
      AppSnackBar.error("You have already reviewed this order.");
      return;
    }

    isLoading.value = true;
    try {
      final response = await SettingRepository.givingRatings(
        sellerId!,
        currentRating.value.toString(),
        review.value.text.trim(),
      );

      if (response == true) {
        // Save this order-seller combination as reviewed
        await saveReviewedOrder(orderId!, sellerId!);

        // Show success message
        AppSnackBar.success("Review submitted successfully!");

        // Update the UI to show review already given
        isReviewAlreadyGiven.value = true;

        // Clear the form
        review.value.clear();
        currentRating.value = 3.0;

        // Optionally go back after a delay
        Future.delayed(Duration(seconds: 2), () {
          Get.back();
        });
      } else {
        AppSnackBar.error("Failed to submit review. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
      appLog('Error submitting review: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    review.value.dispose();
    super.onClose();
  }
}
