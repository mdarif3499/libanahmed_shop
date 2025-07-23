import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/controller/navigation_controller.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/controller/home_screen_controller.dart';
import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/controller/product_details_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const UserProductDetailsScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsController productController = Get.put(
      ProductDetailsController(arguments: arguments),
      permanent: true,
    );
    final NavigationController navController = Get.find<NavigationController>();

    // Update product details when arguments change
    ever(navController.productDetailsArguments, (args) {
      if (args.isNotEmpty) {
        productController.updateProductDetails(args);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.green500,
              size: AppSize.height(value: 40),
            ),
          );
        }

        final product = productController.singleProductDetails.value;
        if (product?.data == null) {
          return Center(
            child: AppText(
              text: "Product not found",
              fontSize: 16,
              color: AppColors.instance.textColor,
            ),
          );
        }

        final productData = product!.data!;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: AppSize.height(value: 275),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: AppImage(
                        url: productData.images?.isNotEmpty == true
                            ? productData.images![0]
                            : '',
                        height: AppSize.height(value: 200),
                        width: AppSize.width(value: 200),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          // Call the add favorite method
                          productController.addFavourite(productData.id ?? "");
                        },
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: AppColors.instance.green50,
                            shape: BoxShape.circle,
                          ),
                          child: Obx(() {
                            // Show loading indicator when adding to favorites
                            if (productController.isAddingFav.value) {
                              return SizedBox(
                                width: 20,
                                height: 20,
                                child: LoadingAnimationWidget.threeArchedCircle(
                                  color: AppColors.instance.green500,
                                  size: AppSize.height(value: 10),
                                ),
                              );
                            }
                            // Show favorite icon with dynamic color
                            return Icon(
                              Icons.favorite,
                              color: (productData.isFavorite == true)
                                  ? AppColors.instance.green500
                                  : AppColors.instance.black200,
                              size: 20,
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(height: 20),
              Row(
                children: [
                  AppText(
                    text:
                        '\$${productData.price?.toStringAsFixed(2) ?? '0.00'}',
                    fontSize: 24,
                    fontFamily: 1,
                    fontWeight: FontWeight.w500,
                    color: AppColors.instance.green500,
                  ),
                  Gap(width: 3),
                  AppText(
                    text: "per unit",
                    fontSize: 16,
                    fontFamily: 1,
                    fontWeight: FontWeight.w400,
                    color: AppColors.instance.white900,
                  ),
                  Spacer(),
                  AppButton(
                    height: AppSize.height(value: 35),
                    width: AppSize.width(value: 35),
                    title: "-",
                    titleColor: AppColors.instance.white,
                    backgroundColor: AppColors.instance.green500,
                    onTap: () {
                      // Implement quantity decrease logic
                    },
                  ),
                  Gap(width: 8),
                  Container(
                    height: AppSize.height(value: 35),
                    width: AppSize.width(value: 53),
                    decoration: BoxDecoration(
                      color: AppColors.instance.blue2_50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: AppText(
                        text: "1",
                        fontWeight: FontWeight.w400,
                        fontFamily: 1,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Gap(width: 8),
                  AppButton(
                    height: AppSize.height(value: 35),
                    width: AppSize.width(value: 35),
                    title: "+",
                    titleColor: AppColors.instance.white,
                    backgroundColor: AppColors.instance.green500,
                    onTap: () {
                      // Implement quantity increase logic
                    },
                  ),
                ],
              ),
              Gap(height: 20),
              AppText(
                text: productData.name ?? "Product Name",
                fontSize: 18,
                fontFamily: 1,
                fontWeight: FontWeight.w700,
                color: AppColors.instance.textColor,
              ),
              Gap(height: 10),
              AppText(
                text: "Product Details",
                fontSize: 16,
                fontFamily: 1,
                fontWeight: FontWeight.w500,
                color: AppColors.instance.textColor,
              ),
              Gap(height: 10),
              AppText(
                text: productData.details ?? "No description available",
                fontWeight: FontWeight.w500,
                fontFamily: 1,
                fontSize: 15,
                maxLines: 8,
                textAlign: TextAlign.justify,
                color: AppColors.instance.textColor,
              ),
              Gap(height: 20),
              AppButton(
                height: AppSize.height(value: 48),
                titleColor: AppColors.instance.white,
                title: AppString.instance.addCart,
                backgroundColor: AppColors.instance.green500,
                borderColor: AppColors.instance.white,
                onTap: () async {
                  HomeScreenController homeController = Get.find();
                  homeController.addtocart(productId: productData.id ?? "");
                  await Future.delayed(Duration(milliseconds: 500));
                  NavigationController.navigateToCart();
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
