import 'dart:io';

import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/models/owner_view_product_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerEditProductScreenController extends GetxController {
  // Loading states
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;

  // Form controllers
  late TextEditingController editProductName;
  late TextEditingController editProductDetails;
  late TextEditingController editPrice;
  late TextEditingController editProductAvailableStock;
  late TextEditingController editWeight;

  // Product data
  RxString productId = ''.obs;
  Rx<Data?> currentProductData = Rx<Data?>(null);

  // Image lists
  RxList<XFile> editImages = <XFile>[].obs;
  RxList<String> editImagesNames = <String>[].obs;

  // Form validation state
  RxBool isFormValid = false.obs;

  // Image picker instance
  final ImagePicker imagePicker = ImagePicker();

  // Get arguments from previous screen
  final arguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();

    // Initialize form controllers
    editProductName = TextEditingController();
    editProductDetails = TextEditingController();
    editPrice = TextEditingController();
    editProductAvailableStock = TextEditingController();
    editWeight = TextEditingController();

    // Setup form validation listeners
    _setupFormValidation();

    // Load product data from arguments
    _loadProductData();
  }

  @override
  void onClose() {
    // Dispose form controllers
    editProductName.dispose();
    editProductDetails.dispose();
    editPrice.dispose();
    editProductAvailableStock.dispose();
    editWeight.dispose();
    super.onClose();
  }

  // Setup form validation listeners
  void _setupFormValidation() {
    editProductName.addListener(_validateForm);
    editProductDetails.addListener(_validateForm);
    editPrice.addListener(_validateForm);
    editProductAvailableStock.addListener(_validateForm);
    editWeight.addListener(_validateForm);
  }

  // Validate form fields
  void _validateForm() {
    isFormValid.value =
        editProductName.text.trim().isNotEmpty &&
        editProductDetails.text.trim().isNotEmpty &&
        editPrice.text.trim().isNotEmpty &&
        editProductAvailableStock.text.trim().isNotEmpty &&
        editWeight.text.trim().isNotEmpty;
  }

  // Load product data from arguments or fetch from API
  void _loadProductData() {
    if (arguments == null) {
      AppSnackBar.error("No product data provided");
      Get.back();
      return;
    }

    productId.value = arguments['productId'] ?? '';
    if (productId.value.isEmpty) {
      AppSnackBar.error("Invalid product ID");
      Get.back();
      return;
    }

    if (arguments['productData'] != null) {
      currentProductData.value = arguments['productData'] as Data;
      _populateFormWithData(currentProductData.value!);
    } else {
      _fetchProductData();
    }
  }

  // Fetch product data from API
  Future<void> _fetchProductData() async {
    try {
      isLoading(true);
      appLog("Fetching product data for ID: ${productId.value}");
      final result = await OwnerProductRepository.fetchSingleProductDetails(
        productId.value,
      );

      if (result != null && result.data != null) {
        currentProductData.value = result.data;
        _populateFormWithData(result.data!);
      } else {
        AppSnackBar.error("Failed to load product details");
        Get.back();
      }
    } catch (e) {
      appLog("Error fetching product data: $e");
      AppSnackBar.error("Failed to load product details: $e");
      Get.back();
    } finally {
      isLoading(false);
    }
  }

  // Populate form with product data
  void _populateFormWithData(Data productData) {
    editProductName.text = productData.name ?? '';
    editProductDetails.text = productData.details ?? '';
    editPrice.text = productData.price?.toString() ?? '';
    editProductAvailableStock.text =
        productData.availableStock?.toString() ?? '';
    editWeight.text = productData.weight?.toString() ?? '';
    _validateForm();
  }

  // Update product via API
  Future<void> updateProduct() async {
    if (!isFormValid.value) {
      AppSnackBar.error("Please fill all required fields");
      return;
    }

    if (productId.value.isEmpty) {
      AppSnackBar.error("Invalid product ID");
      return;
    }

    try {
      isUpdating(true);
      appLog("Updating product with ID: ${productId.value}");

      // Convert XFile to File for API call
      List<File> imageFiles = editImages
          .map((xFile) => File(xFile.path))
          .toList();
      appLog(productId.value);
      final result = await OwnerProductRepository.editProduct(
        productId.value,
        editProductName.text.trim(),
        editProductDetails.text.trim(),
        editPrice.text.trim(),
        editProductAvailableStock.text.trim(),
        editWeight.text.trim(),
        imageFiles,
      );

      if (result == true) {
        AppSnackBar.success("Product updated successfully");
        Get.back();
      } else {
        AppSnackBar.error("Failed to update product");
      }
    } catch (e) {
      appLog("Error updating product: $e");
      AppSnackBar.error("Failed to update product: $e");
    } finally {
      isUpdating(false);
    }
  }

  // Reset form to original values
  void resetForm() {
    if (currentProductData.value != null) {
      _populateFormWithData(currentProductData.value!);
      editImages.clear();
      editImagesNames.clear();
      AppSnackBar.success("Form reset to original values");
    } else {
      AppSnackBar.error("No product data available to reset");
    }
  }

  // Pick multiple images from gallery
  Future<void> pickStoreImages(BuildContext context) async {
    try {
      List<XFile>? pickedFiles = await imagePicker.pickMultiImage();

      if (pickedFiles.isNotEmpty && context.mounted) {
        editImages.assignAll(pickedFiles);
        editImagesNames.assignAll(
          pickedFiles.map((file) => file.name).toList(),
        );
        appLog(
          "Selected ${pickedFiles.length} images: ${editImagesNames.join(', ')}",
        );
        AppSnackBar.success(
          "${pickedFiles.length} images selected successfully",
        );
      } else {
        appLog("No images selected");
      }
    } catch (e) {
      appLog("Error picking images: $e");
      AppSnackBar.error("Failed to pick images. Please try again.");
    }
  }

  // Pick single image from gallery
  Future<void> pickSingleStoreImage(BuildContext context) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        editImages.clear();
        editImages.add(pickedFile);
        editImagesNames.clear();
        editImagesNames.add(pickedFile.name);
        appLog("Selected image: ${pickedFile.name}");
        AppSnackBar.success("Image selected successfully");
      } else {
        appLog("No image selected");
      }
    } catch (e) {
      appLog("Error picking image: $e");
      AppSnackBar.error("Failed to pick image. Please try again.");
    }
  }

  // Capture image from camera
  Future<void> captureStoreImageFromCamera(BuildContext context) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        editImages.add(pickedFile);
        editImagesNames.add(pickedFile.name);
        appLog("Captured image: ${pickedFile.name}");
        AppSnackBar.success("Image captured successfully");
      } else {
        appLog("No image captured");
      }
    } catch (e) {
      appLog("Error capturing image: $e");
      AppSnackBar.error("Failed to capture image. Please try again.");
    }
  }

  // Show image source selection dialog
  Future<void> showStoreImageSourceDialog(BuildContext context) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery (Multiple)"),
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  pickStoreImages(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Gallery (Single)"),
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  pickSingleStoreImage(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  captureStoreImageFromCamera(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Remove image at index
  void removeStoreImage(int index) {
    if (index >= 0 && index < editImages.length) {
      editImages.removeAt(index);
      editImagesNames.removeAt(index);
      appLog("Removed image at index $index");
      AppSnackBar.success("Image removed successfully");
    }
  }

  // Clear all images
  void clearStoreImages() {
    editImages.clear();
    editImagesNames.clear();
    appLog("Cleared all images");
    AppSnackBar.success("All images cleared");
  }

  // Get file size in readable format
  String getFileSize(File file) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    int i = (bytes.bitLength - 1) ~/ 10;
    return "${(bytes / (1 << (i * 10))).toStringAsFixed(1)} ${suffixes[i]}";
  }

  // Get image file info
  Future<Map<String, dynamic>> getImageInfo(XFile imageFile) async {
    File file = File(imageFile.path);
    int fileSize = await file.length();
    return {
      'name': imageFile.name,
      'path': imageFile.path,
      'size': fileSize,
      'sizeFormatted': getFileSize(file),
    };
  }

  // Compress image (optional)
  Future<XFile?> compressImage(XFile imageFile, {int quality = 80}) async {
    try {
      return imageFile; // Implement compression if needed
    } catch (e) {
      appLog("Error compressing image: $e");
      return null;
    }
  }
}
