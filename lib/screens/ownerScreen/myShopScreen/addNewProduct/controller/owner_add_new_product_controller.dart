import 'dart:io';

import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/models/owner_all_categroy_model.dart';
import 'package:ahmed_shop/services/repository/owner_product_repository/owner_product_repository.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constant/app_colors.dart';
import '../../../../../widgets/buttons/app_button.dart';
import '../../../../../widgets/texts/app_text.dart';

class OwnerAddNewProductController extends GetxController {
  //! Loading State
  RxBool isLoading = false.obs;
  RxBool isCategoryLoading = false.obs;

  //! Text Editing Controller
  Rx<TextEditingController> itemNameController = TextEditingController().obs;
  Rx<TextEditingController> itemDescriptionController =
      TextEditingController().obs;
  Rx<TextEditingController> itemPriceContrller = TextEditingController().obs;
  Rx<TextEditingController> itemstockController = TextEditingController().obs;
  Rx<TextEditingController> itemWeightController = TextEditingController().obs;

  //! Category Selection
  var categoryList = <Datum>[].obs;
  Rx<Datum?> selectedCategory = Rx<Datum?>(null);

  //! Product Image List
  RxList<XFile> itemImages = <XFile>[].obs;

  //! Images Name for display
  RxList<String> itemImagesNames = <String>[].obs;

  //! Form Validation State
  RxBool isFormValid = false.obs;

  //! Image Picker Instance
  final ImagePicker imagePicker = ImagePicker();

  //! Ensure controller is permanent to prevent deletion
  static OwnerAddNewProductController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    setupFormValidation();
    fetchAllCategories();
  }

  //! Fetch all categories
  void fetchAllCategories() async {
    try {
      isCategoryLoading(true);
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
      isCategoryLoading(false);
    }
  }

  //! Setup form validation
  void validateForm() {
    bool isValid =
        itemNameController.value.text.trim().isNotEmpty &&
        itemDescriptionController.value.text.trim().isNotEmpty &&
        itemPriceContrller.value.text.trim().isNotEmpty &&
        itemstockController.value.text.trim().isNotEmpty &&
        itemImages.isNotEmpty &&
        itemWeightController.value.text.trim().isNotEmpty &&
        selectedCategory.value != null;

    isFormValid.value = isValid;
  }

  //! Setup form validation listeners
  void setupFormValidation() {
    itemNameController.value.addListener(validateForm);
    itemDescriptionController.value.addListener(validateForm);
    itemPriceContrller.value.addListener(validateForm);
    itemstockController.value.addListener(validateForm);
    itemWeightController.value.addListener(validateForm);

    //! Listen to image changes and category selection
    ever(itemImages, (_) => validateForm());
    ever(selectedCategory, (_) => validateForm());
  }

  @override
  void onClose() {
    itemNameController.value.dispose();
    itemDescriptionController.value.dispose();
    itemPriceContrller.value.dispose();
    itemstockController.value.dispose();
    itemWeightController.value.dispose();
    super.onClose();
  }

  //! Pick store images from gallery
  Future<void> pickStoreImages(BuildContext context) async {
    try {
      List<XFile>? pickedFiles = await imagePicker.pickMultiImage();

      if (pickedFiles.isNotEmpty && context.mounted) {
        itemImages.assignAll(pickedFiles);
        itemImagesNames.assignAll(
          pickedFiles.map((file) => file.name).toList(),
        );

        appLog("Selected ${pickedFiles.length} store images");
        appLog("Store image names: ${itemImagesNames.join(', ')}");

        AppSnackBar.success(
          "${pickedFiles.length} store images selected successfully",
        );
      } else {
        appLog("No store images selected");
      }
    } catch (e) {
      appLog("Error picking store images: $e");
      AppSnackBar.error("Failed to pick store images. Please try again.");
    }
  }

  //! Pick single store image from gallery
  Future<void> pickSingleStoreImage(BuildContext context) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        itemImages.clear();
        itemImages.add(pickedFile);
        itemImagesNames.clear();
        itemImagesNames.add(pickedFile.name);

        appLog("Selected store image: ${pickedFile.name}");
        AppSnackBar.success("Store image selected successfully");
      } else {
        appLog("No store image selected");
      }
    } catch (e) {
      appLog("Error picking store image: $e");
      AppSnackBar.error("Failed to pick store image. Please try again.");
    }
  }

  //! Capture store image from camera
  Future<void> captureStoreImageFromCamera(BuildContext context) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        itemImages.add(pickedFile);
        itemImagesNames.add(pickedFile.name);

        appLog("Captured store image: ${pickedFile.name}");
        AppSnackBar.success("Store image captured successfully");
      } else {
        appLog("No store image captured");
      }
    } catch (e) {
      appLog("Error capturing store image: $e");
      AppSnackBar.error("Failed to capture store image. Please try again.");
    }
  }

  //! Show image source selection dialog for store images
  Future<void> showStoreImageSourceDialog(BuildContext context) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: AppText(
            text: "Select Document Image Source",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            maxLines: 2,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ListTile(
              //   leading: Icon(Icons.photo_library),
              //   title: Text("Gallery (Multiple)"),
              //   onTap: () {
              //     Navigator.of(dialogContext).pop();
              //     pickStoreImages(context);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppButton(
                  title: "Gallery (Multiple)",
                  backgroundColor: AppColors.instance.red500,
                  titleColor: AppColors.instance.white,
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    pickStoreImages(context);
                  },
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.photo),
              //   title: Text("Gallery (Single)"),
              //   onTap: () {
              //     Navigator.of(dialogContext).pop();
              //     pickSingleStoreImage(context);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppButton(
                  title: "Gallery (Single)",
                  backgroundColor: AppColors.instance.red500,
                  titleColor: AppColors.instance.white,
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    pickSingleStoreImage(context);
                  },
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.camera_alt),
              //   title: Text("Camera"),
              //   onTap: () {
              //     Navigator.of(dialogContext).pop();
              //     captureStoreImageFromCamera(context);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppButton(
                  title: "Camera",
                  backgroundColor: AppColors.instance.red500,
                  titleColor: AppColors.instance.white,
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    captureStoreImageFromCamera(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //! Remove store image by index
  void removeStoreImage(int index) {
    if (index >= 0 && index < itemImages.length) {
      itemImages.removeAt(index);
      itemImagesNames.removeAt(index);
      appLog("Removed store image at index $index");
    }
  }

  //! Clear store images
  void clearStoreImages() {
    itemImages.clear();
    itemImagesNames.clear();
    appLog("Cleared store images");
  }

  //! Set selected category
  void setSelectedCategory(Datum? category) {
    selectedCategory.value = category;
  }

  //! Validate individual form fields
  String? validateItemName(String? value) {
    if (value == null || value.isEmpty) {
      return "Item name is required";
    }
    return null;
  }

  String? validateItemPrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Item price is required";
    }
    return null;
  }

  String? validateItemDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Item description is required";
    }
    return null;
  }

  String? validateItemStock(String? value) {
    if (value == null || value.isEmpty) {
      return "Item quantity is required";
    }
    return null;
  }

  String? validateItemWeight(String? value) {
    if (value == null || value.isEmpty) {
      return "Item weight is required";
    }
    return null;
  }

  //! Get file size in readable format
  String getFileSize(File file) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    int i = (bytes.bitLength - 1) ~/ 10;
    return "${(bytes / (1 << (i * 10))).toStringAsFixed(1)} ${suffixes[i]}";
  }

  //! Get image file info
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

  //! Compress image if needed (optional)
  Future<XFile?> compressImage(XFile imageFile, {int quality = 80}) async {
    try {
      // You can implement image compression here if needed
      return imageFile;
    } catch (e) {
      appLog("Error compressing image: $e");
      return null;
    }
  }

  //! Check if all required images are selected
  bool get hasAllRequiredImages => itemImages.isNotEmpty;

  //! Get total number of selected images
  int get totalSelectedImages => itemImages.length;

  //! Submit form Data
  void submitForm() async {
    if (!isFormValid.value) {
      AppSnackBar.error("Please fill all required fields");
      return;
    }

    if (itemImages.isEmpty) {
      AppSnackBar.error("Please select at least one item image");
      return;
    }

    if (selectedCategory.value == null) {
      AppSnackBar.error("Please select a category");
      return;
    }

    try {
      isLoading(true);
      // Convert XFile to File for store images
      List<File> itemImageFiles = itemImages
          .map((xFile) => File(xFile.path))
          .toList();

      bool? result = await OwnerProductRepository.ownerCreateProduct(
        itemNameController.value.text.trim(),
        itemDescriptionController.value.text.trim(),
        itemPriceContrller.value.text.trim(),
        itemstockController.value.text.trim(),
        itemImageFiles,
        itemWeightController.value.text.trim(),
        selectedCategory.value!.id!,
      );

      if (result == true) {
        AppSnackBar.success("Product created successfully!");
        clearForm();
        Get.back();
      } else {
        AppSnackBar.error("Failed to create product. Please try again.");
      }
    } catch (e) {
      appLog("Error submitting form: $e");
      AppSnackBar.error("Failed to submit form. Please try again.");
    } finally {
      isLoading(false);
    }
  }

  void clearForm() {
    itemNameController.value.clear();
    itemDescriptionController.value.clear();
    itemPriceContrller.value.clear();
    itemstockController.value.clear();
    itemWeightController.value.clear();
    selectedCategory.value = null;
    itemImages.clear();
    itemImagesNames.clear();
  }
}
