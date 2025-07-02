import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/controller/user_cart_screen_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserCartScreen extends StatelessWidget {
  const UserCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final CartController controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: Obx(() {
        // Show loading indicator when data is being fetched
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show empty state if cart is empty
        if (controller.cartList.isEmpty) {
          return const Center(
              child: AppText(text: "Your cart is empty", fontSize: 18));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(controller.cartList.length, (index) {
                final cartItem = controller.cartList[index];
                // Safely access productId
                if (cartItem.productId == null) {
                  return const SizedBox.shrink(); // Skip invalid items
                }

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ), // Add margin for spacing
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white,
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: AppColors.instance.authBorderColor),
                  ),
                  child: Row(
                    // Changed from Column to Row to properly use Expanded
                    children: [
                      // Display product image
                      AppImage(
                        url: cartItem.productId?.images?[0] ??
                            'default_image_url',
                        height: AppSize.height(value: 60),
                        width: AppSize.width(value: 60),
                      ),
                      const Gap(
                          width: 10), // Add spacing between image and content
                      // Product details - now properly wrapped in Expanded
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            AppText(
                              text:
                                  cartItem.productId!.name ?? "Unknown Product",
                              fontFamily: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.instance.textColor,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const Gap(height: 10),
                            // Quantity
                            AppText(
                              text: "${cartItem.weight} gm",
                              fontFamily: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.textColor,
                            ),
                            const Gap(height: 10),
                            // Price
                            AppText(
                              text: "\$${cartItem.price}",
                              fontFamily: 2,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.textColor,
                            ),
                          ],
                        ),
                      ),
                      // Actions on the right side
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Close Icon (Remove Item)
                          GestureDetector(
                            onTap: () {
                              if (cartItem.id != null) {
                                controller.deleteCartProduct(
                                  cartItem.id!,
                                );
                              }
                            },
                            child: SvgPicture.asset(
                              AppAssertIcons.cross,
                              height: AppSize.height(value: 25),
                            ),
                          ),
                          const Gap(height: 26),
                          // Quantity Control: +, Quantity, -
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Plus/Increment Button
                              GestureDetector(
                                onTap: () {
                                  if (cartItem.id != null) {
                                    controller.productQuantity(
                                      cartItem.id!,
                                      "increment",
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppAssertIcons.plus,
                                  height: AppSize.height(value: 24),
                                ),
                              ),
                              const Gap(width: 10),
                              // Quantity Display (Reactive)
                              AppText(
                                text: "${cartItem.quantity}",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppColors.instance.textColor,
                              ),
                              const Gap(width: 10),
                              // Minus/Decrement Button
                              GestureDetector(
                                onTap: () {
                                  if (cartItem.id != null) {
                                    controller.productQuantity(
                                      cartItem.id!,
                                      "decrement",
                                    );
                                  }
                                },
                                child: SvgPicture.asset(
                                  AppAssertIcons.minus,
                                  height: AppSize.height(value: 24),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Gap(height: AppSize.height(value: 15)),
              // Total Price and Checkout Button
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.instance.authBorderColor),
                ),
                child: Column(
                  children: [
                    ...List.generate(
                      controller.cartList.length,
                      (index) {
                        final cartItem = controller.cartList[index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  text: cartItem.productId!.name ??
                                      "Unknown Product",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.textColor,
                                ),
                                AppText(
                                  text:
                                      '\$${cartItem.price!.toStringAsFixed(2)}',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.instance.textColor,
                                )
                              ],
                            ),
                            Gap(
                              height: AppSize.height(value: 10),
                            ),
                          ],
                        );
                      },
                    ),
                    Image.asset(AppAssertImage.instance.checkOutImage),
                    Gap(
                      height: AppSize.height(value: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: AppString.instance.totalCost,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.instance.textColor,
                        ),
                        Obx(
                          () => AppText(
                            text:
                                "\$${controller.totalCost.toStringAsFixed(2)}",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(height: AppSize.height(value: 15)),
              AppButton(
                title: AppString.instance.continue1,
                onTap: () {
                  Get.toNamed(AppRoutes.userCheckOut);
                },
                titleColor: AppColors.instance.white,
                backgroundColor: AppColors.instance.green500,
                borderradius: 10,
              ),
              Gap(height: AppSize.height(value: 25)),
            ],
          ),
        );
      }),
    );
  }
}
