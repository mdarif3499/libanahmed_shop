import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/controller/home_screen_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PopularitemScreen extends StatelessWidget {
  const PopularitemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeScreenController productController =
        Get.find<HomeScreenController>();

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.popularItem,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: LoadingAnimationWidget.threeArchedCircle(
                      color: AppColors.instance.red400,
                      size: AppSize.height(value: 40),
                    ));
        }
        if (productController.productList.value?.data?.isEmpty != false) {
          return const Center(child: AppText(text: 'No products available'));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: getResponsiveAspectRatio(
                      context: context,ratioAdjuster: 0.174,), // Adjust based on content
                ),
                itemCount: productController.productList.value?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = productController.productList.value!.data![index];
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
                              url: product.images![0], // Fallback image
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
                        Gap(height: AppSize.height(value: 5)),
                        AppText(
                          text:
                              '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppColors.instance.textColor,
                        ),
                        Gap(height: AppSize.height(value: 6)),
                        IconAppButton(
                          iconAlignment: CustomIconAlignment.right,
                          backgroundColor: AppColors.instance.green500,
                          title: AppString.instance.addCart,
                          icon: AppAssertIcons.userCartButton,
                          height: 35,
                          iconSize: 12,
                          onTap: () {
                            // Implement add to cart logic
                            productController.addtocart(productId: product.id!);
                          },
                          fontSize: 13,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
