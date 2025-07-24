import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuBestSelling/controller/owner_menu_best_seling_items_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/app_aspect_ratio/app_aspect_ratio.dart';
import '../../../../widgets/buttons/icon_app_button.dart';

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
                childAspectRatio: getResponsiveAspectRatio(context: context,ratioAdjuster: 0.174,),
              ),
              itemCount: controller.bestSellingItems.value!.data!.length,
              itemBuilder: (context, index) {
                final product = controller.bestSellingItems.value!.data![index];
                return Expanded(
                  child: Card(
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
                                  )
                                : AppImage(
                                    url: AppAssertImage.instance.strawberry,
                                    height: AppSize.height(value: 94),
                                    width: AppSize.width(value: 94),
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
                            text: "\$${product.price ?? 0}",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: 10),
                          Transform.scale(
                            scale: MediaQuery.of(context).size.width / 360,
                            child: IconAppButton(
                              height: AppSize.height(value: 45),
                              width: AppSize.width(value: 270),
                              iconAlignment: CustomIconAlignment.left,
                              backgroundColor: AppColors.instance.red500,
                              title: AppString.instance.viewDetails,
                              icon: AppAssertIcons.userCartButton,
                              iconSize: 15,
                              onTap: () {},
                            ),
                          ),
                          // AppButton(
                          //   backgroundColor: AppColors.instance.red500,
                          //   title: AppString.instance.viewDetails,
                          //   titleColor: AppColors.instance.white,
                          //   onTap: () {
                          //     // Fixed: Pass the correct product data to the edit screen
                          //     Get.toNamed(
                          //       AppRoutes.ownerEditProduct,
                          //       arguments: {'id': product.id ?? ''},
                          //     );
                          //   },
                          // ),
                        ],
                      ),
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
