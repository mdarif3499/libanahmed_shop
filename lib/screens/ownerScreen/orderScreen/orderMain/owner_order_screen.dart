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
                          controller
                              .toggleOngoingOrder(); 
                        },
                        title: AppString.instance.ongoingOrder,
                        backgroundColor: !controller.isOngoingOrder.value
                            ? AppColors.instance.red500
                            : AppColors.instance.red50,
                        titleColor: !controller.isOngoingOrder.value
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
                          controller
                              .toggleOngoingOrder(); // Set to complete order
                        },
                        title: AppString.instance.completedOrder,
                        backgroundColor: controller.isOngoingOrder.value
                            ? AppColors.instance.red500
                            : AppColors.instance.red50,
                        titleColor: controller.isOngoingOrder.value
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
              if (controller.isOngoingOrder.value) {
                return Column(
                  children: List.generate(5, (index) {
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
                              width: AppSize.width(
                                value: 25,
                              ),
                            ),
                            Gap(width: 13),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: AppString.instance.orderNumber,
                                  fontFamily: 2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.instance.textColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(height: 2),
                                AppText(
                                  text: AppString.instance.southDakota,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.instance.black300,
                                ),
                                Gap(height: 2),
                                AppText(
                                  text: AppString.instance.items,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.instance.black300,
                                ),
                              ],
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
              } else {
                return Column(
                  children: List.generate(6, (index) {
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
                              width: AppSize.width(
                                value: 25,
                              ),
                            ),
                            Gap(width: 13),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: AppString.instance.orderNumber,
                                  fontFamily: 2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppColors.instance.textColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(height: 2),
                                AppText(
                                  text: AppString.instance.southDakota,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.instance.black300,
                                ),
                                Gap(height: 2),
                                AppText(
                                  text: AppString.instance.items,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.instance.black300,
                                ),
                              ],
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
              }
            }),
          ],
        ),
      ),
    );
  }
}
