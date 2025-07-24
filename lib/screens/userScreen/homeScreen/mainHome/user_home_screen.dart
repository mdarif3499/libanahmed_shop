import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/controller/navigation_controller.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/controller/home_screen_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button_row.dart';
import 'package:ahmed_shop/widgets/inputs/app_custom_text_field.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController controller = Get.put(
      HomeScreenController(),
      permanent: true,
    );

    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                hintText: AppString.instance.searchForProduct,
                prefixIconPath: AppAssertIcons.homeSearch,
                prefixIconSize: 15,
                fillColor: AppColors.instance.white,
                filled: true,
                readOnly: true,
                keyboardType: TextInputType.streetAddress,
                onTap: NavigationController.navigateToSearch,
              ),
            ),
            Gap(height: 12),

            //! Category Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppString.instance.category.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.instance.textColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.categories);
                    },
                    child: AppText(
                      text: AppString.instance.seeAll,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.green500,
                    ),
                  ),
                ],
              ),
            ),
            Gap(height: 10),
            //! Categories with Obx for reactive updates
            Obx(() {
              if (controller.isCategoryLoading.value) {
                return SizedBox(
                  height: 120,
                  child: Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: AppColors.instance.green500,
                      size: AppSize.height(value: 40),
                    ),
                  ),
                );
              }

              final categoriesToShow = controller.categoryList.isNotEmpty
                  ? controller.categoryList
                  : [];

              //! Show dynamic categories
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categoriesToShow.length, (index) {
                    final category = categoriesToShow[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              // Use controller's reactive variable instead of local variable
                              controller.showCategoryProducts(category.name!);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.instance.green50,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child:
                                  category.image != null &&
                                      category.image!.isNotEmpty
                                  ? AppImage(
                                      url: category.image!,
                                      height: AppSize.height(value: 60),
                                      width: AppSize.width(value: 60),
                                      shape: ImageShape.circle,
                                    )
                                  : SizedBox(
                                      height: AppSize.height(value: 60),
                                      width: AppSize.width(value: 60),
                                    ),
                            ),
                          ),
                          Gap(height: 10),
                          AppText(
                            text: category.name ?? 'Unknown Category',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.textColor,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              );
            }),

            Gap(height: 10),
            //! New Arrivals Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppString.instance.newArrivals,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.instance.textColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.newArrivals);
                    },
                    child: AppText(
                      text: AppString.instance.seeAll,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.instance.green500,
                    ),
                  ),
                ],
              ),
            ),
            Gap(height: 10),

            // Best Choice Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: AppColors.instance.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: AppString.instance.bestChoice,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 2,
                            color: AppColors.instance.red500,
                          ),
                          Gap(height: AppSize.height(value: 05)),
                          AppText(
                            text: AppString.instance.sweetStrawberries,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 2,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: AppSize.height(value: 05)),
                          AppText(
                            text: AppString.instance.perUnit,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 2,
                            color: AppColors.instance.textColor,
                          ),
                        ],
                      ),
                      Image.asset(
                        AppAssertImage.instance.strawberry,
                        height: AppSize.height(value: 80),
                        width: AppSize.width(value: 80),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(height: 10),

            //! Popular Items Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => AppText(
                      text: controller.isCategoryProductShowing.value
                          ? 'Category Products'
                          : AppString.instance.popularItem,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.instance.textColor,
                    ),
                  ),
                  Row(
                    children: [
                      //! Add "Show All Products" button when showing category products
                      Obx(
                        () => controller.isCategoryProductShowing.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.showAllProducts();
                                },
                                child: AppText(
                                  text: 'Show All',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.red500,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.popularItems);
                        },
                        child: AppText(
                          text: AppString.instance.seeAll,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.instance.green500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(height: 10),

            // Grid for Popular Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Obx(() {
                // Show category products when a category is selected
                if (controller.isCategoryProductShowing.value) {
                  if (controller.isCategoryProductLoading.value) {
                    return Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: AppColors.instance.green500,
                        size: AppSize.height(value: 40),
                      ),
                    );
                  }

                  if (controller.categoryProductList.isEmpty) {
                    return const Center(
                      child: AppText(text: 'No products in this category'),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: getResponsiveAspectRatio(
                        context: context,
                        ratioAdjuster: 0.174,
                      ),
                    ),
                    itemCount: controller.categoryProductList.length,
                    itemBuilder: (context, index) {
                      final product = controller.categoryProductList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.instance.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.instance.black600.withAlpha(51),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: AppImage(
                                  url:
                                      product.images != null &&
                                          product.images!.isNotEmpty
                                      ? product.images![0]
                                      : '', // Provide fallback
                                  height: AppSize.height(value: 95),
                                  width: AppSize.width(value: 95),
                                ),
                              ),
                            ),
                            AppText(
                              text: product.name ?? 'Unnamed Product',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.instance.textColor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            Gap(height: AppSize.height(value: 10)),
                            AppText(
                              text:
                                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.instance.textColor,
                            ),
                            Gap(height: AppSize.height(value: 15)),
                            AppImageButton(
                              title: AppString.instance.addCart,
                              svgPath: AppAssertIcons.userCartButton,
                              backgroundColor: AppColors.instance.green500,
                              imagePosition: ImagePosition.right,
                              height: AppSize.height(value: 40),
                              imageSize: 12,
                              onTap: () {
                                controller.addtocart(productId: product.id!);
                              },
                              fontSize: AppSize.width(value: 13),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                // Show all products (default view)
                if (controller.isProductLoading.value) {
                  return Center(
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: AppColors.instance.green500,
                      size: AppSize.height(value: 40),
                    ),
                  );
                }

                if (controller.productList.isEmpty) {
                  return const Center(
                    child: AppText(text: 'No products available'),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: getResponsiveAspectRatio(
                      context: context,
                      ratioAdjuster: 0.238,
                    ),
                  ),
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index) {
                    final product = controller.productList[index];
                    return InkWell(
                      onTap: () {
                        // Use the navigation controller to show product details within bottom nav
                        NavigationController.navigateToProductDetails(
                          product.id!,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.instance.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.instance.black600.withAlpha(51),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: AppImage(
                                  url:
                                      product.images != null &&
                                          product.images!.isNotEmpty
                                      ? product.images![0]
                                      : '', // Provide fallback
                                  height: AppSize.height(value: 80),
                                  width: AppSize.width(value: 80),
                                ),
                              ),
                            ),
                            AppText(
                              text: product.name ?? 'Unnamed Product',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.instance.textColor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            Gap(height: AppSize.height(value: 06)),
                            AppText(
                              text:
                                  '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.instance.textColor,
                            ),
                            Gap(height: AppSize.height(value: 10)),
                            AppImageButton(
                              title: AppString.instance.addCart,
                              svgPath: AppAssertIcons.userCartButton,
                              backgroundColor: AppColors.instance.green500,
                              imagePosition: ImagePosition.right,
                              height: AppSize.height(value: 40),
                              imageSize: 12,
                              onTap: () {
                                controller.addtocart(productId: product.id!);
                              },
                              fontSize: AppSize.width(value: 13),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
