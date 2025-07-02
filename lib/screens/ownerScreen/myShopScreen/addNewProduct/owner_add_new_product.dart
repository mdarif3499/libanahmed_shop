import 'dart:developer';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OwnerAddNewProduct extends StatelessWidget {
  const OwnerAddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<String>> imageNamesNotifier =
        ValueNotifier<List<String>>([]);
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.productDetails,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: AppString.instance.uploadFoodImage,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.instance.white50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.instance.authBorderColor,
                ),
              ),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      // Trigger image picker to select multiple images
                      final ImagePicker picker = ImagePicker();

                      // Pick multiple images from the gallery
                      List<XFile>? pickedFiles = await picker.pickMultiImage();

                      if (pickedFiles.isNotEmpty) {
                        // Multiple images were picked
                        List<String> fileNames =
                            pickedFiles.map((file) => file.name).toList();

                        // Handle the picked files (e.g., upload them, display their paths, etc.)
                        log("Picked image paths: ${pickedFiles.map((file) => file.path)}");
                        log("Picked image names: $fileNames");

                        // Update the image names list in the notifier
                        imageNamesNotifier.value = fileNames;
                      } else {
                        // User canceled the picker or no images were selected
                        log("No images selected");
                      }
                    },
                    icon: SvgPicture.asset(
                      AppAssertIcons.imageLogo,
                      height: 35,
                      width: 35,
                      colorFilter: ColorFilter.mode(
                        AppColors.instance.textColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  Gap(
                    height: 10,
                  ),
                  // Use ValueListenableBuilder to rebuild the widget when the image names change
                  ValueListenableBuilder<List<String>>(
                    valueListenable: imageNamesNotifier,
                    builder: (context, imageNames, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...imageNames.map((imageName) {
                            return AppText(
                              text: imageName,
                              fontFamily: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Gap(
              height: 20,
            ),
            AppText(
              text: AppString.instance.selectCategory,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
            ),
            Gap(
              height: 20,
            ),
            AppText(
              text: AppString.instance.itemName,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
            ),
            Gap(
              height: 20,
            ),
            AppText(
              text: AppString.instance.itemPrice,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
            ),
            Gap(
              height: 20,
            ),
            AppText(
              text: AppString.instance.itemDetails,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              maxLines: 5,
            ),
            Gap(
              height: 40,
            ),
            AppButton(
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.red500,
              title: AppString.instance.submitNconfirm,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
