import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/controller/user_search_screen_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_custom_text_field.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSearchScreen extends StatelessWidget {
  UserSearchScreen({super.key});
  final UserSearchScreenController controller =
      Get.put(UserSearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: controller.searchController,
                hintText: AppString.instance.searchForProduct,
                prefixIconPath: AppAssertIcons.homeSearch,
                prefixIconSize: 15,
                fillColor: AppColors.instance.white,
                filled: true,
                readOnly: false,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.onSearchChanged(value);
                },
                onTap: () {
                  // You can keep this empty or remove it since we're using onChanged
                },
              ),
            ),
            Gap(
              height: 20,
            ),
            Obx(() {
              // Only show content if there's a search query or results
              if (controller.searchController.text.isEmpty &&
                  controller.searchResults.isEmpty) {
                return SizedBox.shrink(); // Hide everything when no search
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AppText(
                      text: AppString.instance.suggestProduct,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 1,
                      color: AppColors.instance.textColor,
                    ),
                  ),
                  Gap(
                    height: 20,
                  ),
                  // Show loading indicator
                  if (controller.isLoading.value)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: AppColors.instance.green500,
                        ),
                      ),
                    )
                  // Show search results
                  else if (controller.searchResults.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: getResponsiveAspectRatio(context),
                        ),
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final product = controller.searchResults[index];
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
                                    child: AppImage(
                                      url: product.images != null &&
                                              product.images!.isNotEmpty
                                          ? product.images![0]
                                          : '',
                                      height: AppSize.height(value: 95),
                                      width: AppSize.width(value: 95),
                                    ),
                                  ),
                                  Gap(height: 10),
                                  AppText(
                                    text: product.name!,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColors.instance.textColor,
                                  ),
                                  Gap(height: 5),
                                  AppText(
                                    text:
                                        '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColors.instance.textColor,
                                  ),
                                  Gap(height: 10),
                                  IconAppButton(
                                    iconAlignment: CustomIconAlignment.right,
                                    backgroundColor:
                                        AppColors.instance.green500,
                                    title: AppString.instance.addCart,
                                    icon: AppAssertIcons.userCartButton,
                                    height: AppSize.height(value: 45),
                                    iconSize: 15,
                                    onTap: () {
                                      controller.addtocart(
                                          productId: product.id!);
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  // Show no results message
                  else if (controller.searchController.text.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AppText(
                          text: "No products found",
                          fontSize: 16,
                          color: AppColors.instance.textColor,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
