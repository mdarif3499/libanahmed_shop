import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuOffer/models/create_offer_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_log.dart';

class OwnerCreateOfferController extends GetxController {
  var isLoading = false.obs;
  var isCreatingOffer = false.obs;
  var offerProductList = Rxn<CreateOfferModel>();
  var selectedProduct = Rxn<Data>();
  var selectedProductName = ''.obs;

  var startingDateText = ''.obs;
  var endingDateText = ''.obs;

  late TextEditingController offerPercent;
  late TextEditingController startingDate;
  late TextEditingController endingDate;

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void onInit() {
    super.onInit();
    offerPercent = TextEditingController();
    startingDate = TextEditingController();
    endingDate = TextEditingController();

    startingDate.addListener(() {
      startingDateText.value = startingDate.text;
    });

    endingDate.addListener(() {
      endingDateText.value = endingDate.text;
    });

    fetchOfferProductList();
  }

  @override
  void onClose() {
    offerPercent.dispose();
    startingDate.dispose();
    endingDate.dispose();
    super.onClose();
  }

  void fetchOfferProductList() async {
    try {
      isLoading(true);
      var result = await OwnerProductRepository.fetchCreateOffer();
      if (result != null && result.success == true) {
        offerProductList.value = result;
      } else {
        Get.snackbar("Error", "Failed to load products for offer");
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      appLog("Error fetching offer products: $e");
      Get.snackbar("Error", "An error occurred while loading products");
    }
  }

  void setSelectedProduct(Data product) {
    selectedProduct.value = product;
    selectedProductName.value = product.name ?? "Unknown Product";
  }

  void setStartDate(DateTime date) {
    selectedStartDate = date;
    startingDate.text = "${date.day}/${date.month}/${date.year}";
  }

  void setEndDate(DateTime date) {
    selectedEndDate = date;
    endingDate.text = "${date.day}/${date.month}/${date.year}";
  }

  String formatDateForAPI(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T00:00:00Z";
  }

  bool validateForm() {
    if (selectedProduct.value == null) {
      Get.snackbar("Error", "Please select a product");
      return false;
    }

    if (offerPercent.text.isEmpty) {
      Get.snackbar("Error", "Please enter offer percentage");
      return false;
    }

    if (selectedStartDate == null) {
      Get.snackbar("Error", "Please select start date");
      return false;
    }

    if (selectedEndDate == null) {
      Get.snackbar("Error", "Please select end date");
      return false;
    }

    if (selectedEndDate!.isBefore(selectedStartDate!)) {
      Get.snackbar("Error", "End date must be after start date");
      return false;
    }

    final offerValue = double.tryParse(offerPercent.text);
    if (offerValue == null || offerValue <= 0 || offerValue > 100) {
      Get.snackbar("Error", "Please enter a valid offer percentage (1-100)");
      return false;
    }

    return true;
  }

  void createOffer() async {
    if (!validateForm()) return;

    try {
      isCreatingOffer(true);

      final result = await OwnerProductRepository.createOffer(
        selectedProduct.value!.sId!,
        offerPercent.text,
        formatDateForAPI(selectedStartDate!),
        formatDateForAPI(selectedEndDate!),
      );

      if (result == true) {
        Get.snackbar("Success", "Offer created successfully");
        clearForm();
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to create offer");
      }

      isCreatingOffer(false);
    } catch (e) {
      isCreatingOffer(false);
      appLog("Error creating offer: $e");
      Get.snackbar("Error", "An error occurred while creating offer");
    }
  }

  void clearForm() {
    selectedProduct.value = null;
    selectedProductName.value = '';
    offerPercent.clear();
    startingDate.clear();
    endingDate.clear();
    selectedStartDate = null;
    selectedEndDate = null;
  }
}
