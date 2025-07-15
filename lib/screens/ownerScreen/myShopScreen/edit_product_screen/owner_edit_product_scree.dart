import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/edit_product_screen/controller/owner_edit_product_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OwnerEditProductScreen extends StatefulWidget {
  const OwnerEditProductScreen({super.key});

  @override
  State<OwnerEditProductScreen> createState() => _OwnerEditProductScreenState();
}

class _OwnerEditProductScreenState extends State<OwnerEditProductScreen> {
  final OwnerEditProductScreenController controller = Get.put(
    OwnerEditProductScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Edit Product",
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(height: AppSize.height(value: 20)),
              //! Product Name
              AppText(
                text: "Remane Product",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.editProductName,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: controller.editProductName.text.isEmpty
                    ? "Rename Product"
                    : null,
                keyboardType: TextInputType.text,
              ),
              Gap(height: AppSize.height(value: 20)),
              //! Product Description
              AppText(
                text: "Rewrite Description",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.editProductDetails,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: controller.editProductDetails.text.isEmpty
                    ? "Enter product description"
                    : null,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              Gap(height: AppSize.height(value: 20)),
              //! Product Price
              AppText(
                text: "Rewrite Price",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.editPrice,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: controller.editPrice.text.isEmpty
                    ? "Enter item price"
                    : null,
                keyboardType: TextInputType.number,
              ),
              Gap(height: AppSize.height(value: 20)),
              //! Product Stock
              AppText(
                text: "Rewrite Stock",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.editProductAvailableStock,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: controller.editProductAvailableStock.text.isEmpty
                    ? "Rewrite the Stock"
                    : null,
                keyboardType: TextInputType.number,
              ),
              Gap(height: AppSize.height(value: 20)),
              //! Product Weight
              AppText(
                text: "Rewrite weight",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.editWeight,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: controller.editWeight.text.isEmpty
                    ? "Rewrite the Weight"
                    : null,
                keyboardType: TextInputType.text,
              ),
              Gap(height: AppSize.height(value: 20)),
              //! Enter new Images
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
                          ...controller.editImagesNames.map((imageName) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 2,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      int index = controller.editImagesNames
                                          .indexOf(imageName);
                                      controller.removeStoreImage(index);
                                    },
                                    icon: Icon(Icons.close, size: 16),
                                  ),
                                ],
                              ),
                            );
                          }),
                          if (controller.editImagesNames.isEmpty)
                            AppText(
                              text: "No images selected",
                              fontFamily: 2,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: AppColors.instance.textColor.withAlpha(
                                155,
                              ),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Gap(height: AppSize.height(value: 25)),
              //! Submit the edit button
              Obx(() {
                return AppButton(
                  titleColor: AppColors.instance.white,
                  backgroundColor: AppColors.instance.red500,
                  title: controller.isUpdating.value
                      ? "Updating..."
                      : "Saved & Changed",
                  onTap: controller.isUpdating.value
                      ? null
                      : () => controller.updateProduct(),
                );
              }),
              Gap(height: AppSize.height(value: 20)),
            ],
          ),
        );
      }),
    );
  }
}
