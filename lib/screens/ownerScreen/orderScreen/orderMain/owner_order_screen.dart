import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderMain/controller/owner_order_screen_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerOrderScreen extends StatelessWidget {
  const OwnerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerOrderScreenController controller =
    Get.put(OwnerOrderScreenController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
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
                          controller.toggleOngoingOrder(true); // Pass true for ongoing orders
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
                          controller.toggleOngoingOrder(false); // Pass false for completed orders
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
                  })
                ],
              ),
            ),
            Gap(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.instance.red500,
                  ),
                );
              }

              if (controller.ownerOrderList.value?.data == null ||
                  controller.ownerOrderList.value!.data!.isEmpty) {
                return Center(
                  child: AppText(
                    text: "No orders found",
                    fontSize: 16,
                    color: AppColors.instance.textColor,
                  ),
                );
              }

              return Column(
                children: List.generate(
                  controller.ownerOrderList.value!.data!.length,
                      (index) {
                    final order = controller.ownerOrderList.value!.data![index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.ownerOrderProgress);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.instance.red50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    text: "Order #${order.Id?.substring(0, 8) ?? 'N/A'}",
                                    fontFamily: 2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: AppColors.instance.textColor,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gap(height: 2),
                                  AppText(
                                    text: order.address ?? order.locality ?? "Address not available",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.instance.black300,
                                  ),
                                  Gap(height: 2),
                                  AppText(
                                    text: "${order.productList?.length ?? 0} items - \$${order.totalAmount ?? 0}",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.instance.black300,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Handle order action (e.g., cancel, view details)
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
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}