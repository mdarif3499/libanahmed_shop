import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/orderProgress/controller/order_progress_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserOrderProgress extends StatefulWidget {
  const UserOrderProgress({super.key});

  @override
  _UserOrderProgressState createState() => _UserOrderProgressState();
}

class _UserOrderProgressState extends State<UserOrderProgress> {
  late final OrderProgressController controller;
  String? orderId;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OrderProgressController());

    // Get the order ID from arguments
    orderId = Get.arguments as String?;

    // Fetch order details if orderId is available
    if (orderId != null) {
      controller.showSingleOrderData(orderId!);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.instance.green500,
            ),
          );
        }

        if (controller.singleOrderList.isEmpty) {
          return Center(
            child: AppText(
              text: "Order not found",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.black300,
            ),
          );
        }

        final orderData = controller.singleOrderList.first;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                "Order #${orderData.sId?.substring(orderData.sId!.length - 6) ?? 'N/A'}",
                            fontFamily: 2,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.instance.textColor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(height: 2),
                          AppText(
                            text: orderData.address ?? 'N/A',
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
                                "${orderData.productList?.length ?? 0} items - \$${orderData.totalAmount ?? 0}",
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
              Gap(height: 15),

              // Progress Steps based on order history
              _buildProgressSteps(orderData.history ?? []),

              Gap(height: 20),
              AppButton(
                title: AppString.instance.viewOrder,
                titleColor: AppColors.instance.textColor,
                backgroundColor: AppColors.instance.white,
                borderColor: AppColors.instance.textColor,
                onTap: () {
                  Get.toNamed(AppRoutes.viewOrder, arguments: orderId);
                },
              ),
              Gap(height: 20),
              AppButton(
                title: AppString.instance.giveRatings,
                titleColor: AppColors.instance.white,
                backgroundColor: AppColors.instance.green500,
                onTap: () {
                  if (controller.singleOrderList.isNotEmpty) {
                    Get.toNamed(AppRoutes.menuRating, arguments: [
                      controller.singleOrderList.first.sellerId,
                      controller.singleOrderList.first.sId
                    ]);
                  } else {
                    // Handle empty list case
                    AppSnackBar.error("Order details not available");
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProgressSteps(List<dynamic> history) {
    // Define the order progression steps
    final steps = [
      {
        'key': 'completed',
        'title': 'Order Placed',
        'icon': AppAssertIcons.stepper1
      },
      {
        'key': 'recived',
        'title': 'Order Received',
        'icon': AppAssertIcons.stepper2
      },
      {
        'key': 'ongoing',
        'title': 'Processing',
        'icon': AppAssertIcons.stepper3
      },
      {
        'key': 'delivery',
        'title': 'Out for Delivery',
        'icon': AppAssertIcons.stepper4
      },
      {
        'key': 'finished',
        'title': 'Delivered',
        'icon': AppAssertIcons.stepper4
      },
    ];

    return Column(
      children: steps.map((step) {
        // Find if this step has a date in history - FIXED VERSION
        dynamic historyItem;
        try {
          historyItem = history.firstWhere(
            (h) => h != null && h is Map && h['status'] == step['key'],
          );
        } catch (e) {
          // If no matching item found, set to null
          historyItem = null;
        }

        final isCompleted = historyItem != null && historyItem['date'] != null;
        final stepDate = historyItem?['date'];

        return Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? AppColors.instance.green500
                        : AppColors.instance.black300,
                  ),
                  child: SvgPicture.asset(
                    step['icon'] as String,
                    color: AppColors.instance.white,
                  ),
                ),
                Gap(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: step['title'] as String,
                        fontFamily: 1,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: isCompleted
                            ? AppColors.instance.textColor
                            : AppColors.instance.black300,
                      ),
                      Gap(height: 5),
                      AppText(
                        text: stepDate != null
                            ? _formatDate(stepDate)
                            : 'Pending',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 1,
                        color: AppColors.instance.black300,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (step != steps.last) Gap(height: 25),
          ],
        );
      }).toList(),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Pending';

    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }
}
