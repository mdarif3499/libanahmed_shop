import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/controller/owner_order_screen_controller.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerOrderScreen extends StatelessWidget {
  const OwnerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerOrderScreenController controller = Get.put(
      OwnerOrderScreenController(),
    );

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Toggle buttons
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.instance.red50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Obx(() {
                    return Expanded(
                      child: AppButton(
                        onTap: () {
                          controller.toggleOngoingOrder(true);
                          appLog(
                            'UI: Toggled to Ongoing Orders',
                          ); // Debug print
                        },
                        title: AppString.instance.ongoingOrder,
                        backgroundColor: controller.isOngoingOrdertoggle.value
                            ? AppColors.instance.red500
                            : AppColors.instance.red50,
                        titleColor: controller.isOngoingOrdertoggle.value
                            ? AppColors.instance.white
                            : AppColors.instance.unselectedButton,
                        borderradius: 8,
                      ),
                    );
                  }),
                  Gap(width: 10),
                  Obx(() {
                    return Expanded(
                      child: AppButton(
                        onTap: () {
                          controller.toggleOngoingOrder(false);
                          appLog(
                            'UI: Toggled to Completed Orders',
                          ); // Debug print
                        },
                        title: AppString.instance.completedOrder,
                        backgroundColor: !controller.isOngoingOrdertoggle.value
                            ? AppColors.instance.red500
                            : AppColors.instance.red50,
                        titleColor: !controller.isOngoingOrdertoggle.value
                            ? AppColors.instance.white
                            : AppColors.instance.unselectedButton,
                        borderradius: 8,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Gap(height: 10),

            // Main content
            Obx(() {
              appLog(
                'UI: Rebuilding with isOngoing=${controller.isOngoingOrdertoggle.value}, orders count=${controller.currentOrdersData.length}',
              ); // Debug print
              if (controller.isLoading.value) {
                return Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: AppColors.instance.red400,
                    size: AppSize.height(value: 40),
                  ),
                );
              }

              // Get current orders based on toggle state
              final currentOrders = controller.currentOrdersData;

              if (currentOrders.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Gap(height: 50),
                      AppText(
                        text: controller.isOngoingOrdertoggle.value
                            ? "No ongoing orders found"
                            : "No completed orders found",
                        fontSize: 16,
                        color: AppColors.instance.textColor,
                      ),
                      Gap(height: 20),
                      AppButton(
                        width: AppSize.width(value: 150),
                        onTap: () {
                          controller.refreshAllOrders();
                        },
                        title: "Refresh",
                        backgroundColor: AppColors.instance.red500,
                        titleColor: AppColors.instance.white,
                        borderradius: 8,
                      ),
                      Gap(height: 20),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     controller.refreshAllOrders();
                      //   },
                      //   child: Text('Refresh'),
                      // ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Header showing count
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: controller.isOngoingOrdertoggle.value
                              ? "Ongoing Orders (${currentOrders.length})"
                              : "Completed Orders (${currentOrders.length})",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.instance.textColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.refreshAllOrders();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: AppColors.instance.red500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Orders list using Column
                  Column(
                    children: currentOrders.map((order) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.ownerOrderProgress,
                            arguments: order.id,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.instance.red50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: controller.isOngoingOrdertoggle.value
                                  ? AppColors.instance.red500.withAlpha(85)
                                  : Colors.green.withAlpha(85),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssertIcons.trackOrderIcon,
                                height: AppSize.height(value: 25),
                                width: AppSize.width(value: 25),
                              ),
                              Gap(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text:
                                          "Order #${order.id?.substring(order.id!.length - 6) ?? 'N/A'}",
                                      fontFamily: 2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: AppColors.instance.textColor,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Gap(height: 2),
                                    AppText(
                                      text:
                                          order.addressLine1 ??
                                          order.addressLine2 ??
                                          "Address not available",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.instance.black300,
                                    ),
                                    Gap(height: 2),
                                    AppText(
                                      text:
                                          "${order.productList?.length ?? 0} items - \$${order.totalAmount ?? 0}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 2,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.instance.black300,
                                    ),
                                    Gap(height: 2),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                controller
                                                    .isOngoingOrdertoggle
                                                    .value
                                                ? AppColors.instance.red500
                                                      .withAlpha(35)
                                                : Colors.green.withAlpha(35),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: AppText(
                                            text: order.status ?? 'Unknown',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                controller
                                                    .isOngoingOrdertoggle
                                                    .value
                                                ? AppColors.instance.red500
                                                : Colors.green,
                                          ),
                                        ),
                                        Gap(width: 5),
                                        AppText(
                                          text:
                                              "Payment: ${order.paymentStatus ?? 'Unknown'}",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.instance.black300,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Handle order action
                                },
                                child: SvgPicture.asset(
                                  AppAssertIcons.trackOrderCross,
                                  height: AppSize.height(value: 35),
                                  width: AppSize.width(value: 35),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
