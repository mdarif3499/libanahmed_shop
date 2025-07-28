import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/services/repository/owner_shop_creation_repository/owner_shop_creation_repository.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerStoreVerificationController extends GetxController {
  //! Loading state
  RxBool isLoading = false.obs;

  //! Form controllers
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeDescriptionController =
      TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();

  //! Image lists - both store images and document images
  RxList<XFile> storeImages = <XFile>[].obs;
  RxList<XFile> documentImages = <XFile>[].obs;

  //! Image names for display
  RxList<String> storeImageNames = <String>[].obs;
  RxList<String> documentImageNames = <String>[].obs;

  //! Form validation
  RxBool isFormValid = false.obs;

  //! Image picker instance
  final ImagePicker _imagePicker = ImagePicker();

  //! Ensure controller is permanent to prevent deletion
  static OwnerStoreVerificationController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    //! Listen to form changes for validation
    _setupFormValidation();
    //! Mark controller as permanent to prevent deletion
    Get.put(this, permanent: true);
  }

  @override
  void onClose() {
    //! Dispose controllers
    storeNameController.dispose();
    storeDescriptionController.dispose();
    super.onClose();
  }

  //! Setup form validation listeners
  void _setupFormValidation() {
    storeNameController.addListener(_validateForm);
    storeDescriptionController.addListener(_validateForm);

    //! Listen to image changes
    ever(storeImages, (_) => _validateForm());
    ever(documentImages, (_) => _validateForm());
  }

  //! Validate form fields
  void _validateForm() {
    bool isValid =
        storeNameController.text.trim().isNotEmpty &&
        storeDescriptionController.text.trim().isNotEmpty &&
        storeImages.isNotEmpty &&
        documentImages.isNotEmpty;

    isFormValid.value = isValid;
  }

  //! Pick store images from gallery
  Future<void> pickStoreImages(BuildContext context) async {
    try {
      List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();

      if (pickedFiles.isNotEmpty && context.mounted) {
        storeImages.assignAll(pickedFiles);
        storeImageNames.assignAll(
          pickedFiles.map((file) => file.name).toList(),
        );

        log("Selected ${pickedFiles.length} store images");
        log("Store image names: ${storeImageNames.join(', ')}");

        AppSnackBar.success(
          "${pickedFiles.length} store images selected successfully",
        );
      } else {
        log("No store images selected");
      }
    } catch (e) {
      log("Error picking store images: $e");
      AppSnackBar.error("Failed to pick store images. Please try again.");
    }
  }

  //! Pick single store image from gallery
  Future<void> pickSingleStoreImage(BuildContext context) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 5,
      );

      if (pickedFile != null && context.mounted) {
        storeImages.clear();
        storeImages.add(pickedFile);
        storeImageNames.clear();
        storeImageNames.add(pickedFile.name);

        log("Selected store image: ${pickedFile.name}");
        AppSnackBar.success("Store image selected successfully");
      } else {
        log("No store image selected");
      }
    } catch (e) {
      log("Error picking store image: $e");
      AppSnackBar.error("Failed to pick store image. Please try again.");
    }
  }

  //! Pick store image from camera
  Future<void> captureStoreImageFromCamera(BuildContext context) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 5,
      );

      if (pickedFile != null && context.mounted) {
        storeImages.add(pickedFile);
        storeImageNames.add(pickedFile.name);

        log("Captured store image: ${pickedFile.name}");
        AppSnackBar.success("Store image captured successfully");
      } else {
        log("No store image captured");
      }
    } catch (e) {
      log("Error capturing store image: $e");
      AppSnackBar.error("Failed to capture store image. Please try again.");
    }
  }

  //! Pick document images from gallery
  Future<void> pickDocumentImages(BuildContext context) async {
    try {
      List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();

      if (pickedFiles.isNotEmpty && context.mounted) {
        documentImages.assignAll(pickedFiles);
        documentImageNames.assignAll(
          pickedFiles.map((file) => file.name).toList(),
        );

        log("Selected ${pickedFiles.length} document images");
        log("Document image names: ${documentImageNames.join(', ')}");

        AppSnackBar.success(
          "${pickedFiles.length} document images selected successfully",
        );
      } else {
        log("No document images selected");
      }
    } catch (e) {
      log("Error picking document images: $e");
      AppSnackBar.error("Failed to pick document images. Please try again.");
    }
  }

  //! Pick single document image from gallery
  Future<void> pickSingleDocumentImage(BuildContext context) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null && context.mounted) {
        documentImages.clear();
        documentImages.add(pickedFile);
        documentImageNames.clear();
        documentImageNames.add(pickedFile.name);

        log("Selected document image: ${pickedFile.name}");
        AppSnackBar.success("Document image selected successfully");
      } else {
        log("No document image selected");
      }
    } catch (e) {
      log("Error picking document image: $e");
      AppSnackBar.error("Failed to pick document image. Please try again.");
    }
  }

  //! Pick document image from camera
  Future<void> captureDocumentImageFromCamera(BuildContext context) async {
    try {
      XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 5,
      );

      if (pickedFile != null && context.mounted) {
        documentImages.add(pickedFile);
        documentImageNames.add(pickedFile.name);

        log("Captured document image: ${pickedFile.name}");
        AppSnackBar.success("Document image captured successfully");
      } else {
        log("No document image captured");
      }
    } catch (e) {
      log("Error capturing document image: $e");
      AppSnackBar.error("Failed to capture document image. Please try again.");
    }
  }

  //! Show image source selection dialog for store images
  Future<void> showStoreImageSourceDialog(BuildContext context) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 05, sigmaY: 05),
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            actionsPadding: EdgeInsets.all(10),
            title: AppText(
              text: "Select Image Source",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              maxLines: 2,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
          ),
        );
      },
    );
  }

  //! Show image source selection dialog for document images
  Future<void> showDocumentImageSourceDialog(BuildContext context) async {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 05, sigmaY: 05),
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            actionsPadding: EdgeInsets.all(10),
            title: AppText(
              text: "Select License Image",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              maxLines: 2,
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppButton(
                      title: "Gallery (Single)",
                      backgroundColor: AppColors.instance.red500,
                      titleColor: AppColors.instance.white,
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        pickSingleDocumentImage(context);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppButton(
                      title: "Camera",
                      backgroundColor: AppColors.instance.red500,
                      titleColor: AppColors.instance.white,
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        captureDocumentImageFromCamera(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //! Remove store image by index
  void removeStoreImage(int index) {
    if (index >= 0 && index < storeImages.length) {
      storeImages.removeAt(index);
      storeImageNames.removeAt(index);
      log("Removed store image at index $index");
    }
  }

  //! Remove document image by index
  void removeDocumentImage(int index) {
    if (index >= 0 && index < documentImages.length) {
      documentImages.removeAt(index);
      documentImageNames.removeAt(index);
      log("Removed document image at index $index");
    }
  }

  //! Clear all store images
  void clearStoreImages() {
    storeImages.clear();
    storeImageNames.clear();
    log("Cleared all store images");
  }

  //! Clear all document images
  void clearDocumentImages() {
    documentImages.clear();
    documentImageNames.clear();
    log("Cleared all document images");
  }

  //! Validate individual fields
  String? validateStoreName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Store name is required';
    }
    if (value.trim().length < 3) {
      return 'Store name must be at least 3 characters';
    }
    return null;
  }

  String? validateStoreAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Store address is required';
    }
    if (value.trim().length < 10) {
      return 'Store address must be at least 10 characters';
    }
    return null;
  }

  String? validateStoreDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Store description is required';
    }
    if (value.trim().length < 10) {
      return 'Store description must be at least 10 characters';
    }
    return null;
  }

  //! Convert XFile to Uint8List
  // Future<Uint8List> _convertToBytes(XFile image) async {
  //   File file = File(image.path);
  //   return Uint8List.fromList(await file.readAsBytes());
  // }

  //! Submit form data
  Future<void> submitStoreVerification() async {
    if (!isFormValid.value) {
      AppSnackBar.error("Please fill all required fields");
      return;
    }
    if (storeImages.isEmpty) {
      AppSnackBar.error("Please select at least one store image");
      return;
    }
    if (documentImages.isEmpty) {
      AppSnackBar.error("Please select at least one document image");
      return;
    }

    try {
      isLoading.value = true;

      // Validate form fields
      String? nameError = validateStoreName(storeNameController.text);
      if (nameError != null) {
        AppSnackBar.error(nameError);
        return;
      }

      String? addressError = validateStoreAddress(storeAddressController.text);
      if (addressError != null) {
        AppSnackBar.error(addressError);
        return;
      }

      String? descriptionError = validateStoreDescription(
        storeDescriptionController.text,
      );
      if (descriptionError != null) {
        AppSnackBar.error(descriptionError);
        return;
      }

      //! Convert XFile to File for store images
      List<File> storeImageFiles = storeImages
          .map((xFile) => File(xFile.path))
          .toList();
      //! Convert XFile to File for document images
      List<File> documentImageFiles = documentImages
          .map((xFile) => File(xFile.path))
          .toList();

      // Validate files exist
      for (File file in storeImageFiles) {
        if (!await file.exists()) {
          AppSnackBar.error("Store image file not found: ${file.path}");
          return;
        }
      }

      for (File file in documentImageFiles) {
        if (!await file.exists()) {
          AppSnackBar.error("Document file not found: ${file.path}");
          return;
        }
      }

      log("Submitting shop creation with:");
      log("Name: ${storeNameController.text.trim()}");
      log("Address: ${storeAddressController.text.trim()}");
      log("Description: ${storeDescriptionController.text.trim()}");
      log("Store images: ${storeImageFiles.length}");
      log("Document images: ${documentImageFiles.length}");

      //! Call repository method with Dio Multipart files
      bool? result = await OwnerShopCreationRepository.shopCreation(
        storeNameController.text.trim(),
        storeAddressController.text.trim(),
        storeDescriptionController.text.trim(),
        storeImageFiles,
        documentImageFiles,
      );

      if (result == true) {
        AppSnackBar.success("Store verification submitted successfully!");
        _clearForm();
        Get.offNamed(AppRoutes.ownerBottomNav);
      } else {
        AppSnackBar.error(
          "Failed to submit store verification. Please check your data and try again.",
        );
      }
    } catch (e) {
      log("Error submitting store verification: $e");
      AppSnackBar.error("An error occurred: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  //! Clear form data
  void _clearForm() {
    storeNameController.clear();
    storeAddressController.clear();
    storeDescriptionController.clear();
    storeImages.clear();
    documentImages.clear();
    storeImageNames.clear();
    documentImageNames.clear();
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
      //! You can implement image compression here if needed
      return imageFile;
    } catch (e) {
      log("Error compressing image: $e");
      return null;
    }
  }

  //! Check if all required images are selected
  bool get hasAllRequiredImages =>
      storeImages.isNotEmpty && documentImages.isNotEmpty;
  //! Get total number of selected images
  int get totalSelectedImages => storeImages.length + documentImages.length;
}
