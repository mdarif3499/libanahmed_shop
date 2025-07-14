import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuBestSelling/controller/owner_menu_best_seling_items_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerMenuBestSellingItems extends StatelessWidget {
  final OwnerMenuBestSelingItemsController controller = Get.put(
    OwnerMenuBestSelingItemsController(),
  );
  OwnerMenuBestSellingItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.bestSellingItems,
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
          return Center(child: CircularProgressIndicator());
        }

        if (controller.bestSellingItems.value == null ||
            controller.bestSellingItems.value!.data == null ||
            controller.bestSellingItems.value!.data!.isEmpty) {
          return Center(
            child: AppText(
              text: "No best selling items found",
              fontSize: 16,
              color: AppColors.instance.textColor,
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Padding(
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
              itemCount: controller.bestSellingItems.value!.data!.length,
              itemBuilder: (context, index) {
                final product = controller.bestSellingItems.value!.data![index];
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
                              ? Image.network(
                                  product.images![0],
                                  height: 94,
                                  width: 94,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppAssertImage
                                          .instance
                                          .strawberry, // fallback image
                                      height: 94,
                                      width: 94,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppAssertImage
                                      .instance
                                      .strawberry, // fallback image
                                  height: 94,
                                  width: 94,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Gap(height: 10),
                        AppText(
                          text: product.name ?? "Unknown Product",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(height: 5),
                        AppText(
                          text: "৳${product.price ?? 0}",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(height: 10),
                        IconAppButton(
                          iconAlignment: CustomIconAlignment.right,
                          backgroundColor: AppColors.instance.red500,
                          title: AppString.instance.viewDetails,
                          icon: AppAssertIcons.userCartButton,
                          iconSize: 15,
                          onTap: () {},
                        ),
                      ],
                    ),
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
