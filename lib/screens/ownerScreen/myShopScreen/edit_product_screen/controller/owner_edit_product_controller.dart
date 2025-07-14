import 'dart:io';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';

class OwnerEditProductScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<TextEditingController> editProductName = TextEditingController().obs;
  Rx<TextEditingController> editProductDetails = TextEditingController().obs;
  Rx<TextEditingController> editPrice = TextEditingController().obs;
  Rx<TextEditingController> editProductAvaiableStock =
      TextEditingController().obs;
  Rx<TextEditingController> editWeight = TextEditingController().obs;

  //! Product Image List
  RxList<XFile> editImages = <XFile>[].obs;

  //! Images Name for display
  RxList<String> editImagesNames = <String>[].obs;

  //! Form Validation State
  RxBool isFormValid = false.obs;

  //! Image Picker Instance
  final ImagePicker imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  //! Pick store images from gallery
  Future<void> pickStoreImages(BuildContext context) async {
    try {
      List<XFile>? pickedFiles = await imagePicker.pickMultiImage();

      if (pickedFiles.isNotEmpty && context.mounted) {
        editImages.assignAll(pickedFiles);
        editImagesNames.assignAll(
          pickedFiles.map((file) => file.name).toList(),
        );

        appLog("Selected ${pickedFiles.length} store images");
        appLog("Store image names: ${editImagesNames.join(', ')}");

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
        editImages.clear();
        editImages.add(pickedFile);
        editImagesNames.clear();
        editImagesNames.add(pickedFile.name);

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
        editImages.add(pickedFile);
        editImagesNames.add(pickedFile.name);

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
  void removeStoreImage(int index) {
    if (index >= 0 && index < editImages.length) {
      editImages.removeAt(index);
      editImagesNames.removeAt(index);
      appLog("Removed store image at index $index");
    }
  }

  //! Clear store images
  void clearStoreImages() {
    editImages.clear();
    editImagesNames.clear();
    appLog("Cleared store images");
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
}
