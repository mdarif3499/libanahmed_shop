import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/controller/home_screen_controller.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuFavourite/controller/user_menu_favourite_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button_row.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserManuFavourite extends StatelessWidget {
  const UserManuFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    final UserMenuFavouriteController controller = Get.put(
      UserMenuFavouriteController(),
    );

    // Fetch data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllFavourite();
    });

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.myFavorites,
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
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: Obx(() {
        // Show loading indicator while fetching data
        if (controller.isFavourite.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.green500,
              size: AppSize.height(value: 40),
            ),
          );
        }

        // Show empty state if no data
        if (controller.favouriteItem.value == null ||
            controller.favouriteItem.value!.data == null ||
            controller.favouriteItem.value!.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssertIcons.favFill, height: 60, width: 60),
                SizedBox(height: 16),
                AppText(
                  text: "No favorite items found",
                  color: AppColors.instance.greyTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          );
        }

        // Display favorite items
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: List.generate(
              controller.favouriteItem.value!.data!.length,
              (index) {
                final item = controller.favouriteItem.value!.data![index];
                final product = item.productId;

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: AppColors.instance.green50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            product?.images != null &&
                                product!.images!.isNotEmpty
                            ? AppImage(
                                url: product.images!.first,
                                height: AppSize.height(value: 65),
                                width: AppSize.width(value: 65),
                              )
                            : Image.asset(
                                AppAssertImage.instance.appleJuice,
                                height: AppSize.height(value: 65),
                                width: AppSize.width(value: 65),
                                fit: BoxFit.cover,
                              ),
                      ),
                      // Product Details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: product?.name ?? "Product Name",
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: AppColors.instance.textColor,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              AppText(
                                text: product?.categoryName ?? "Category",
                                color: AppColors.instance.greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 4),
                              AppText(
                                text: product?.price != null
                                    ? "\$${product!.price!.toStringAsFixed(2)}"
                                    : "\$0",
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: AppColors.instance.textColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //
                      //Favorite Icon
                      AppImageButton(
                        title: AppString.instance.addCart,
                        svgPath: AppAssertIcons.userCartButton,
                        backgroundColor: AppColors.instance.green500,
                        imagePosition: ImagePosition.right,
                        height: AppSize.height(value: 32),
                        width: AppSize.width(value: 90),
                        imageSize: 12,
                        onTap: () async {
                          final controller = Get.put(HomeScreenController());
                          controller.addtocart(productId: product!.id!);
                        },
                        fontSize: AppSize.width(value: 13),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
