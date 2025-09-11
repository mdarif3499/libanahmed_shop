import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/storeVefication/controller/owner_store_verification_controller.dart';
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
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerMyShop extends StatefulWidget {
  const OwnerMyShop({super.key});

  @override
  State<OwnerMyShop> createState() => _OwnerMyShopState();
}

class _OwnerMyShopState extends State<OwnerMyShop> with WidgetsBindingObserver {
  int _selectedIndex =
      0; // Track the selected button index, default to 0 (first button)
  late OwnerShopController controller;
  String _lastRefreshTime = "";

  @override
  void initState() {
    super.initState();
    // Add observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);

    // Initialize controller and fetch data
    controller = Get.put(OwnerShopController());
    _refreshData();
  }

  @override
  void dispose() {
    // Remove observer when widget is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh data when app comes back to foreground
    if (state == AppLifecycleState.resumed) {
      appLog("App resumed - refreshing data");
      _refreshData();
    }
  }

  // Method to refresh all data (silent refresh)
  void _refreshData() {
    appLog("Refreshing owner shop data...");
    controller.ownerOverViewCheck();
    // Also refresh products and categories if setup is complete
    controller.refreshData();

    // Update last refresh time
    setState(() {
      _lastRefreshTime = DateTime.now().toString().substring(
        11,
        19,
      ); // HH:MM:SS format
    });
  }

  // Method for manual refresh with user feedback
  void _manualRefresh() {
    _refreshData();

    // Show refresh feedback for manual refresh
    if (mounted) {
      Get.snackbar(
        "Data Refreshed",
        "Shop data updated at $_lastRefreshTime",
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.bottom,
        backgroundColor: AppColors.instance.green500.withValues(alpha: 0.8),
        colorText: AppColors.instance.white,
        margin: const EdgeInsets.all(10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final OwnerStoreVerificationController storeController = Get.put(
      OwnerStoreVerificationController(),
    );

    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: Obx(() {
        // Show loading while fetching overview data
        if (controller.isOwnerOverviewCheckLoading.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.red400,
              size: AppSize.height(value: 40),
            ),
          );
        }

        final overviewData = controller.ownerOverviewCheckList.value?.data;

        // Check if ALL setup steps are completed
        final isProfileUpdated = overviewData?.profileUpdate ?? false;
        final isStripeConnected = overviewData?.stripeConnectedAccount ?? false;
        final isShopCreated = overviewData?.shopCreateVarify ?? false;

        // Show shop content only if ALL three are true
        final isFullySetup =
            isProfileUpdated && isStripeConnected && isShopCreated;

        return RefreshIndicator(
          onRefresh: () async {
            appLog("Pull to refresh triggered");
            _manualRefresh();
            // Wait for the loading to complete
            while (controller.isOwnerOverviewCheckLoading.value) {
              await Future.delayed(const Duration(milliseconds: 100));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            physics:
                const AlwaysScrollableScrollPhysics(), // Enable pull-to-refresh even when content doesn't scroll
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with refresh button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: isFullySetup
                          ? AppString.instance.viewingShop
                          : "Complete Your Setup",
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      fontFamily: 2,
                      color: AppColors.instance.textColor,
                    ),
                    IconButton(
                      onPressed: () {
                        appLog("Manual refresh button pressed");
                        _manualRefresh();
                      },
                      icon: Obx(
                        () => AnimatedRotation(
                          turns: controller.isOwnerOverviewCheckLoading.value
                              ? 1
                              : 0,
                          duration: const Duration(milliseconds: 500),
                          child: Icon(
                            Icons.refresh,
                            color: AppColors.instance.textColor,
                            size: 24,
                          ),
                        ),
                      ),
                      tooltip: "Refresh data",
                    ),
                  ],
                ),
                const Gap(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: isFullySetup
                          ? AppString.instance.productIsarrange
                          : "Complete all setup steps to start selling",
                      fontFamily: 2,
                      color: AppColors.instance.greyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    if (_lastRefreshTime.isNotEmpty) ...[
                      const Gap(height: 5),
                      AppText(
                        text: "Last updated: $_lastRefreshTime",
                        fontFamily: 2,
                        color: AppColors.instance.greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ],
                ),
                const Gap(height: 20),

                // Conditional content based on full setup status
                if (isFullySetup) ...[
                  // All setup complete - show categories and products
                  _buildShopContent(controller),
                ] else ...[
                  // Setup incomplete - show setup buttons
                  _buildSetupContent(overviewData, storeController),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  // Widget for verified shop content (categories and products)
  Widget _buildShopContent(OwnerShopController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category buttons
        Obx(() {
          if (controller.isCategory.value) {
            return SizedBox(
              height: 40,
              child: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.instance.red400,
                  size: AppSize.height(value: 40),
                ),
              ),
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

        Gap(height: AppSize.height(value: 20)),

        // Products Grid
        Obx(() {
          // Show loading indicator
          if (controller.isProduct.value ||
              controller.isCategoryProductLoading.value) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.instance.red400,
                  size: AppSize.height(value: 40),
                ),
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
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: getResponsiveAspectRatio(
                context: context,
                ratioAdjuster: 0.260,
              ),
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
                            product.images != null && product.images!.isNotEmpty
                            ? AppImage(
                                url: product.images![0],
                                height: AppSize.height(value: 94),
                                width: AppSize.width(value: 94),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppAssertImage.instance.strawberry,
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
                      const Gap(height: 5),
                      AppText(
                        text: '\$${(product.price ?? 0).toStringAsFixed(2)}',
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
                          appLog('Navigating with product ID: ${product.id}');
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

        const Gap(height: 20),

        // Add Product Button
        AppButton(
          titleColor: AppColors.instance.white,
          backgroundColor: AppColors.instance.red500,
          title: AppString.instance.addProduct,
          onTap: () {
            Get.toNamed(AppRoutes.ownerAddNewProduct);
          },
        ),
      ],
    );
  }

  // Widget for setup content (when shop is not verified)
  Widget _buildSetupContent(
    dynamic overviewData,
    OwnerStoreVerificationController storeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Setup Status Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.instance.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Setup Progress",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.instance.textColor,
              ),
              const Gap(height: 15),

              // Profile Update Status
              _buildStatusItem(
                "Profile Update",
                overviewData?.profileUpdate ?? false,
                Icons.person,
              ),
              const Gap(height: 10),

              // Shop Creation Status
              _buildStatusItem(
                "Shop Creation",
                overviewData?.shopCreateVarify ?? false,
                Icons.store,
              ),
              const Gap(height: 10),

              // Stripe Account Status
              _buildStatusItem(
                "Payment Setup",
                overviewData?.stripeConnectedAccount ?? false,
                Icons.payment,
              ),
            ],
          ),
        ),

        const Gap(height: 30),

        // Action Buttons
        AppText(
          text: "Complete Setup",
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.instance.textColor,
        ),
        const Gap(height: 15),

        // Update Profile Button (highest priority)
        if (!(overviewData?.profileUpdate ?? false)) ...[
          AppButton(
            title: "Update Profile",
            titleColor: AppColors.instance.white,
            backgroundColor: AppColors.instance.red500,
            onTap: () {
              Get.toNamed(AppRoutes.ownerEditProfile);
            },
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          const Gap(height: 15),
        ],

        // Create Shop Button
        if (!(overviewData?.shopCreateVarify ?? false)) ...[
          Obx(
            () => AppButton(
              title: storeController.isLoading.value
                  ? "Creating..."
                  : "Create Shop",
              titleColor: AppColors.instance.white,
              backgroundColor: storeController.isLoading.value
                  ? AppColors.instance.greyColor
                  : AppColors.instance.red500,
              onTap: storeController.isLoading.value
                  ? null
                  : () {
                      Get.toNamed(AppRoutes.ownerStoreVerification);
                    },
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const Gap(height: 15),
        ],

        // Connect Stripe Account Button
        if (!(overviewData?.stripeConnectedAccount ?? false)) ...[
          AppButton(
            title: "Connect Payment Account",
            titleColor: AppColors.instance.white,
            backgroundColor: AppColors.instance.green500,
            onTap: () {
              Get.toNamed(AppRoutes.ownerMenuPaymentMethod);
            },
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          const Gap(height: 15),
        ],

        const Gap(height: 20),

        // Info Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.instance.red50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.instance.red200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.instance.red500,
                size: 24,
              ),
              const Gap(width: 12),
              Expanded(
                child: AppText(
                  text:
                      "All three setup steps must be completed before you can access your shop, view categories, and manage products.",
                  fontSize: 14,
                  color: AppColors.instance.red700,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget for status items
  Widget _buildStatusItem(String title, bool isCompleted, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.instance.green100
                : AppColors.instance.red100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isCompleted
                ? AppColors.instance.green600
                : AppColors.instance.red600,
          ),
        ),
        const Gap(width: 12),
        Expanded(
          child: AppText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.instance.textColor,
          ),
        ),
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted
              ? AppColors.instance.green600
              : AppColors.instance.greyColor,
          size: 24,
        ),
      ],
    );
  }
}
