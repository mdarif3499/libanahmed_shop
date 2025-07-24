import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderDetails/models/owner_order_details_model.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderProgress/controller/owner_order_progress_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OwnerOrderProgress extends StatefulWidget {
  const OwnerOrderProgress({super.key});

  @override
  _OwnerOrderProgressState createState() => _OwnerOrderProgressState();
}

class _OwnerOrderProgressState extends State<OwnerOrderProgress> {
  late final OwnerOrderProgressController controller;
  String? orderId;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OwnerOrderProgressController());

    // Get the order ID from arguments
    orderId = Get.arguments as String?;

    // Fetch order details if orderId is available
    if (orderId != null) {
      controller.showSingleOrderData(orderId!);

      // Listen for order data changes and fetch tracking if available
      ever(controller.detailsList, (orderData) {
        if (orderData != null && controller.canTrackOrder()) {
          final trackingNumber = controller.getTrackingNumber();
          if (trackingNumber != null) {
            controller.showTrackingOrderData(trackingNumber);
          }
        }
      });
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
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: AppColors.instance.red500,
              size: AppSize.height(value: 40),
            ),
          );
        }

        if (controller.detailsList.value == null) {
          return Center(
            child: AppText(
              text: "Order not found",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.instance.black300,
            ),
          );
        }

        final orderData = controller.detailsList.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Order Details Container
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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
                            text:
                                "Order #${orderData.id?.substring(orderData.id!.length - 6) ?? 'N/A'}",
                            fontFamily: 2,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.instance.textColor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(height: 2),
                          AppText(
                            text: orderData.addressLine1 ?? 'N/A',
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
                          Gap(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: controller.isOrderPaid()
                                      ? Colors.green.withAlpha(35)
                                      : AppColors.instance.red500.withAlpha(35),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: AppText(
                                  text: orderData.status ?? 'Unknown',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: controller.isOrderPaid()
                                      ? Colors.green
                                      : AppColors.instance.red500,
                                ),
                              ),
                              Gap(width: 5),
                              AppText(
                                text:
                                    "Payment: ${orderData.paymentStatus ?? 'Unknown'}",
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

              // Show tracking information for orders with tracking number
              if (controller.canTrackOrder()) ...[
                _buildTrackingSection(),
                Gap(height: 20),
              ],

              // Order Progress Steps
              //_buildProgressSteps(orderData),
              Gap(height: 20),
              // View Order Button
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
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTrackingSection() {
    return Obx(() {
      if (controller.isTrackingLoading.value) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.instance.red50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.instance.red500),
          ),
        );
      }

      final trackingData = controller.trackingOrderDataList.value;
      if (trackingData?.data?.trackResponse?.shipment?.isNotEmpty == true) {
        final shipment = trackingData!.data!.trackResponse!.shipment!.first;
        final package = shipment.package?.isNotEmpty == true
            ? shipment.package!.first
            : null;

        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.instance.red50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Tracking Information',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.instance.red500,
              ),
              Gap(height: 15),
              if (shipment.inquiryNumber != null) ...[
                _buildTrackingRow(
                  'Tracking Inquiry Number:',
                  shipment.inquiryNumber!,
                ),
                Gap(height: 8),
              ],
              if (package?.trackingNumber != null) ...[
                _buildTrackingRow('Tracking Number:', package!.trackingNumber!),
                Gap(height: 8),
              ],
              if (package?.currentStatus?.description != null) ...[
                _buildTrackingRow(
                  'Current Status:',
                  package!.currentStatus!.description!,
                ),
                Gap(height: 8),
              ],
              if (package?.currentStatus?.code != null) ...[
                _buildTrackingRow(
                  'Simplified Status:',
                  _getSimplifiedStatus(package!.currentStatus!.code!),
                ),
                Gap(height: 8),
              ],
              if (package?.deliveryInformation != null) ...[
                _buildTrackingRow('Delivery Location:', 'Front Door'),
                Gap(height: 8),
              ],
              if (package?.packageCount != null) ...[
                _buildTrackingRow(
                  'Package Count:',
                  package!.packageCount.toString(),
                ),
                Gap(height: 8),
              ],
              if (package?.service?.description != null) ...[
                _buildTrackingRow(
                  'Service Description:',
                  package!.service!.description!,
                ),
              ],
            ],
          ),
        );
      }

      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.instance.red50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            AppText(
              text: 'Tracking Information',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.instance.red500,
            ),
            Gap(height: 10),
            AppText(
              text:
                  'Tracking information will be available once the package is shipped.',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.black300,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTrackingRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: AppText(
            text: label,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.instance.black800,
          ),
        ),
        Gap(width: 10),
        Expanded(
          child: AppText(
            text: value,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.instance.black600,
          ),
        ),
      ],
    );
  }

  String _getSimplifiedStatus(String statusCode) {
    switch (statusCode.toLowerCase()) {
      case 'd':
      case 'delivered':
        return 'Delivered';
      case 'in_transit':
      case 'i':
        return 'In Transit';
      case 'out_for_delivery':
      case 'o':
        return 'Out for Delivery';
      case 'exception':
      case 'x':
        return 'Exception';
      default:
        return 'In Progress';
    }
  }
}
