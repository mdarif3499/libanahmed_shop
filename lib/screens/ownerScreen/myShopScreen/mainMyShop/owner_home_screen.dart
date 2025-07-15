import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/mainMyShop/controller/owner_shop_controller.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerMyShop extends StatefulWidget {
  const OwnerMyShop({super.key});

  @override
  State<OwnerMyShop> createState() => _OwnerMyShopState();
}

class _OwnerMyShopState extends State<OwnerMyShop> {
  int _selectedIndex =
      0; // Track the selected button index, default to 0 (first button)
  @override
  Widget build(BuildContext context) {
    final OwnerShopController controller = Get.put(OwnerShopController());

    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: AppString.instance.viewingShop,
              fontWeight: FontWeight.w500,
              fontSize: 19,
              fontFamily: 2,
              color: AppColors.instance.textColor,
            ),
            const Gap(height: 10),
            AppText(
              text: AppString.instance.productIsarrange,
              fontFamily: 2,
              color: AppColors.instance.greyTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            const Gap(height: 20),

            // Category buttons
            Obx(() {
              if (controller.isCategory.value) {
                return SizedBox(
                  height: 40,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              // Create button titles with "All" as first item
              List<String> buttonTitles = [AppString.instance.all];
              if (controller.categoryList.isNotEmpty) {
                buttonTitles.addAll(
                  controller.categoryList
                      .map((category) => category.name ?? '')
                      .toList(),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(buttonTitles.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AppButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });

                          if (index == 0) {
                            // "All" button clicked
                            controller.showAllProducts();
                          } else {
                            // Category button clicked
                            String categoryName =
                                controller.categoryList[index - 1].name ?? '';
                            controller.showCategoryProducts(categoryName);
                          }
                        },
                        title: buttonTitles[index],
                        titleColor: AppColors.instance.textColor,
                        backgroundColor: _selectedIndex == index
                            ? AppColors.instance.red500
                            : AppColors.instance.red50,
                      ),
                    );
                  }),
                ),
              );
            }),

            Gap(height: 20),

            // Products Grid
            Obx(() {
              // Show loading indicator
              if (controller.isProduct.value ||
                  controller.isCategoryProductLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Determine which products to show
              final productsToShow = controller.isCategoryProductShowing.value
                  ? controller.categoryProductList
                  : controller.productList;

              // Check if productList is empty when no category is selected
              if (!controller.isCategoryProductShowing.value &&
                  controller.productList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: AppText(
                      text: 'There is no item in the product list',
                      fontSize: 16,
                    ),
                  ),
                );
              }

              // Check if categoryProductList is empty when a category is selected
              if (controller.isCategoryProductShowing.value &&
                  controller.categoryProductList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: AppText(
                      text: 'No products available in this category',
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: getResponsiveAspectRatio(context),
                ),
                itemCount: productsToShow.length,
                itemBuilder: (context, index) {
                  final product = productsToShow[index];
                  return Card(
                    color: AppColors.instance.white,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:
                                product.images != null &&
                                    product.images!.isNotEmpty
                                ? AppImage(
                                    url: product.images![0],
                                    height: AppSize.height(value: 94),
                                    width: AppSize.width(value: 94),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppAssertImage
                                        .instance
                                        .strawberry, // Default image
                                    height: AppSize.height(value: 94),
                                    width: AppSize.width(value: 94),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Gap(height: AppSize.height(value: 10)),
                          AppText(
                            text: product.name ?? 'Unnamed Product',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: 5),
                          AppText(
                            text:
                                '\$${(product.price ?? 0).toStringAsFixed(2)}',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: AppSize.height(value: 10)),
                          AppButton(
                            backgroundColor: AppColors.instance.red500,
                            title: AppString.instance.viewDetails,
                            titleColor: AppColors.instance.white,
                            onTap: () {
                              appLog(
                                'Navigating with product ID: ${product.id}',
                              ); // Debug print
                              Get.toNamed(
                                AppRoutes.ownerEditProduct,
                                arguments: {'id': product.id ?? ''},
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),

            Gap(height: 20),
            AppButton(
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.red500,
              title: AppString.instance.addProduct,
              onTap: () {
                Get.toNamed(AppRoutes.ownerAddNewProduct);
              },
            ),
          ],
        ),
      ),
    );
  }
}
