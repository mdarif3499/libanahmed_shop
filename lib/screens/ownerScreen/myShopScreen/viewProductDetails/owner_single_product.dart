import 'dart:ui';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/controller/owner_edit_product_controller.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerSingleProductScreen extends StatelessWidget {
  const OwnerSingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OwnerEditProductController());
    void showDeleteDialog(BuildContext context, String? productId) {
      if (productId == null || productId.isEmpty) {
        Get.snackbar('Error', 'Invalid product ID');
        return;
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.zero,
              content: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.instance.white100,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(height: AppSize.height(value: 20)),
                    AppText(
                      text: 'Are you sure to delete this product?',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.instance.textColor,
                      maxLines: 2,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                          height: AppSize.height(value: 48),
                          width: AppSize.width(value: 60),
                          title: "No",
                          titleColor: AppColors.instance.white100,
                          backgroundColor: AppColors.instance.green500,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        AppButton(
                          height: AppSize.height(value: 48),
                          width: AppSize.width(value: 60),
                          title: "Yes",
                          titleColor: AppColors.instance.white100,
                          backgroundColor: AppColors.instance.red500,
                          onTap: () {
                            controller.deleteProduct(productId);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Gap(height: AppSize.height(value: 20)),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

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
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: Obx(() {
        final model = controller.singleProductDetails.value;
        final productData = model?.data;
        final isLoading = controller.isLoading.value;

        if (isLoading) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.red400,
              size: AppSize.height(value: 40),
            ),
          );
        }

        // Debug information
        if (model != null) {
          appLog("Model Success: ${model.success}");
          appLog("Model Message: ${model.message}");
          appLog("Model Data: ${model.data}");
          appLog("Product Data null: ${productData == null}");
        }

        if (productData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'Failed to load product details',
                  fontSize: 16,
                  color: Colors.red,
                ),
                const Gap(height: 10),
                AppText(
                  text: 'Product ID: ${controller.productID.value}',
                  fontSize: 12,
                  color: Colors.grey,
                ),
                const Gap(height: 10),
                AppText(
                  text:
                      'Model: ${controller.singleProductDetails.value?.toString() ?? "null"}',
                  fontSize: 12,
                  color: Colors.grey,
                  maxLines: 3,
                ),
                const Gap(height: 20),
                AppButton(
                  title: "Retry",
                  onTap: () =>
                      controller.loadProductData(controller.productID.value),
                  backgroundColor: AppColors.instance.red500,
                  titleColor: AppColors.instance.white,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Container
              Container(
                height: AppSize.height(value: 200),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: productData.images?.isNotEmpty ?? false
                      ? AppImage(
                          url: productData.images!.first,
                          height: AppSize.height(value: 180),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          borderRadius: 10,
                        )
                      : Image.asset(
                          AppAssertImage.instance.apple,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const Gap(height: 20),

              // Product Name and Price Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: productData.name?.isNotEmpty ?? false
                        ? productData.name!
                        : AppString.instance.naturelRedApple,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.instance.textColor,
                    fontFamily: 2,
                  ),
                  AppText(
                    text: productData.price != null
                        ? '\$${productData.price!.toStringAsFixed(2)}'
                        : '\$0.00',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.instance.textColor,
                    fontFamily: 2,
                  ),
                ],
              ),
              const Gap(height: 10),

              // Weight/Unit Display
              AppText(
                text: productData.weight != null && productData.weight! > 0
                    ? '${productData.weight} ${AppString.instance.oneKg}'
                    : '500g',
                fontSize: 16,
                fontFamily: 1,
                fontWeight: FontWeight.w500,
                color: AppColors.instance.greyTextColor,
              ),
              const Gap(height: 10),

              // Product Description
              AppText(
                text: productData.details?.isNotEmpty ?? false
                    ? productData.details!
                    : AppString.instance.every500Gram,
                fontSize: 14,
                fontFamily: 1,
                fontWeight: FontWeight.w500,
                color: AppColors.instance.textColor,
                textAlign: TextAlign.justify,
                maxLines: 5,
              ),
              const Gap(height: 30),

              // Additional Product Images
              if ((productData.images?.length ?? 0) > 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: 'More Images',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.textColor,
                    ),
                    const Gap(height: 10),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productData.images?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AppImage(
                                url: productData.images![index],
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                                borderRadius: 8,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Gap(height: 30),
                  ],
                ),

              // Product ID Display
              if (controller.productID.value.isNotEmpty) ...[
                AppText(
                  text: 'Product ID: ${controller.productID.value}',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.instance.greyTextColor,
                ),
                const Gap(height: 20),
              ],
              const Gap(height: 20),
              // Edit Product Button
              AppButton(
                titleColor: AppColors.instance.white,
                backgroundColor: AppColors.instance.red500,
                title: AppString.instance.editProduct,
                onTap: () => Get.toNamed(
                  AppRoutes.ownerEditProductScreen,
                  arguments: {
                    'productId': controller.productID.value,
                    'productData': productData,
                  },
                ),
              ),
              const Gap(height: 20),
              //! Delete Product Button
              AppButton(
                titleColor: AppColors.instance.red500,
                backgroundColor: AppColors.instance.white,
                borderColor: AppColors.instance.red500,
                title: 'Delete Product',
                onTap: () => showDeleteDialog(context, productData.id),
              ),
              const Gap(height: 40),
            ],
          ),
        );
      }),
    );
  }
}
