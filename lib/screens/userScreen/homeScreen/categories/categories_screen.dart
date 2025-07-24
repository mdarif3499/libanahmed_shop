import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/controller/home_screen_controller.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_aspect_ratio/app_aspect_ratio.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Safe controller initialization - check if exists, if not create new one
    final HomeScreenController controller =
        Get.isRegistered<HomeScreenController>()
            ? Get.find<HomeScreenController>()
            : Get.put(HomeScreenController());

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.category,
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
        elevation: 0, // Remove shadow if needed
      ),
      backgroundColor: AppColors
          .instance.userPhoneBackground, // Match home screen background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            // Show loading state
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Show empty state
            if (controller.categoryList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.category_outlined,
                      size: 64,
                      color: AppColors.instance.grey400,
                    ),
                    Gap(height: 16),
                    AppText(
                      text: 'No categories available',
                      fontSize: 16,
                      color: AppColors.instance.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(height: 8),
                    AppText(
                      text: 'Categories will appear here once loaded',
                      fontSize: 14,
                      color: AppColors.instance.grey600,
                    ),
                  ],
                ),
              );
            }

            // Show categories grid
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: getResponsiveAspectRatio(context: context,ratioAdjuster: 0.174,),
              ),
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                final category = controller.categoryList[index];
                return GestureDetector(
                  onTap: () {
                    appLog('Category tapped: ${category.name}');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.instance.green50,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.instance.black600.withAlpha(25),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Category Image Container
                        category.image != null && category.image!.isNotEmpty
                            ? AppImage(
                                url: category.image!,
                                height: AppSize.height(value: 50),
                                width: AppSize.width(value: 50),
                                shape: ImageShape.circle,
                              )
                            : Container(
                                height: AppSize.height(value: 32),
                                width: AppSize.width(value: 32),
                                decoration: BoxDecoration(
                                  color: AppColors.instance.grey200,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(
                                  Icons.category_outlined,
                                  size: 20,
                                  color: AppColors.instance.grey500,
                                ),
                              ),
                        Gap(height: 20),
                        // Category Name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: AppText(
                            text: category.name ?? 'Unknown',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.textColor,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
