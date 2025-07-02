import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/controller/user_track_order_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserTrackOrder extends StatelessWidget {
  const UserTrackOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserTrackOrderController());
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.trackOrder,
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
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            // Order state buttons
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.instance.green50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Obx(() {
                    return Expanded(
                      child: AppButton(
                        onTap: () {
                          controller.toggleOrderState(false);
                        },
                        title: AppString.instance.ongoingOrder,
                        backgroundColor: !controller.isCompleteOrder.value
                            ? AppColors.instance.green500
                            : AppColors.instance.white,
                        titleColor: !controller.isCompleteOrder.value
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
                          controller.toggleOrderState(true);
                        },
                        title: AppString.instance.completedOrder,
                        backgroundColor: controller.isCompleteOrder.value
                            ? AppColors.instance.green500
                            : AppColors.instance.white,
                        titleColor: controller.isCompleteOrder.value
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

            // Order details based on state (ongoing or complete)
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.instance.green500,
                  ),
                );
              }

              if (controller.orderList.isEmpty) {
                return Center(
                  child: AppText(
                    text: "No orders found",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.instance.black300,
                  ),
                );
              }

              return Column(
                children: List.generate(controller.orderList.length, (index) {
                  var order = controller.orderList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.userOrderProgress,
                          arguments: order.sId);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.instance.green50,
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
                                  text:
                                      "Order #${order.sId?.substring(order.sId!.length - 6) ?? 'N/A'}",
                                  fontFamily: 2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.instance.textColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(height: 2),
                                AppText(
                                  text: order.address ?? 'N/A',
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
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
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
                }),
              );
            }),
            Gap(height: 15),
            Row(
              children: [
                AppText(
                  text: AppString.instance.needHelp,
                  fontFamily: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColors.instance.unselectedButton,
                ),
                Gap(width: 5),
                AppText(
                  text: AppString.instance.contactUs,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 1,
                  color: AppColors.instance.green500,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
