import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/addNewProduct/controller/owner_add_new_product_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerAddNewProduct extends StatelessWidget {
  const OwnerAddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(OwnerAddNewProductController());

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
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            Gap(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.instance.white50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.instance.authBorderColor),
              ),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.showStoreImageSourceDialog(context);
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
                  Gap(height: 10),
                  // Use Obx to listen to image changes
                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...controller.itemImagesNames.map((imageName) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: imageName,
                                    fontFamily: 2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    int index = controller.itemImagesNames
                                        .indexOf(imageName);
                                    controller.removeStoreImage(index);
                                  },
                                  icon: Icon(Icons.close, size: 16),
                                ),
                              ],
                            ),
                          );
                        }),
                        if (controller.itemImagesNames.isEmpty)
                          AppText(
                            text: "No images selected",
                            fontFamily: 2,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.instance.textColor.withAlpha(155),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Gap(height: 20),
            AppText(
              text: AppString.instance.selectCategory,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            // Category Dropdown
            Obx(() {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.instance.authBorderColor),
                ),
                child: controller.isCategoryLoading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.instance.red400,
                            size: AppSize.height(value: 30),
                          ),
                        ),
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedCategory.value?.id,
                          hint: AppText(
                            text: "Select Category",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.textColor.withAlpha(155),
                          ),
                          isExpanded: true,
                          items: controller.categoryList.map((category) {
                            return DropdownMenuItem<String>(
                              value: category.id,
                              child: AppText(
                                text: category.name ?? "Unknown Category",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.instance.textColor,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? categoryId) {
                            if (categoryId != null) {
                              var selectedCat = controller.categoryList
                                  .firstWhere((cat) => cat.id == categoryId);
                              controller.setSelectedCategory(selectedCat);
                            }
                          },
                        ),
                      ),
              );
            }),
            Gap(height: 20),
            AppText(
              text: AppString.instance.itemName,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemNameController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item name",
            ),
            Gap(height: 20),
            AppText(
              text: AppString.instance.itemPrice,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemPriceContrller.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item price",
              keyboardType: TextInputType.number,
            ),
            Gap(height: 20),
            AppText(
              text: "Item Stock",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemstockController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item stock quantity",
              keyboardType: TextInputType.number,
            ),
            Gap(height: 20),
            AppText(
              text: "Item Weight (Pounds)",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemWeightController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item weight",
            ),
            Gap(height: 20),
            //! Height
            AppText(
              text: "Resize Height (CM)",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemHeightController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item height",
            ),
            Gap(height: 20),
            //! Length
            AppText(
              text: "Resize Length (CM)",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemLengthController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item length",
            ),
            Gap(height: 20),
            //! Width
            AppText(
              text: "Resize Width (CM)",
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemWidthController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              hintText: "Enter item width",
            ),
            Gap(height: 20),
            AppText(
              text: AppString.instance.itemDetails,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            AppInputWidget(
              controller: controller.itemDescriptionController.value,
              fillColor: AppColors.instance.white,
              borderColor: AppColors.instance.authBorderColor,
              maxLines: 5,
              hintText: "Enter item description",
            ),
            Gap(height: 40),
            Obx(() {
              return AppButton(
                titleColor: AppColors.instance.white,
                backgroundColor: controller.isFormValid.value
                    ? AppColors.instance.red500
                    : AppColors.instance.red500.withAlpha(155),
                title: controller.isLoading.value
                    ? "Submitting..."
                    : AppString.instance.submitNconfirm,
                onTap:
                    controller.isLoading.value || !controller.isFormValid.value
                    ? null
                    : () {
                        controller.submitForm();
                      },
              );
            }),
          ],
        ),
      ),
    );
  }
}
