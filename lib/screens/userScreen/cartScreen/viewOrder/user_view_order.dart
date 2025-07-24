import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/viewOrder/controller/view_order_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserViewOrder extends StatelessWidget {
  final String orderId;

  const UserViewOrder({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ViewDetailsSingleOrderController());

    // Fetch order details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.showSingleOrderData(orderId);
    });

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.viewOrder,
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
        if (controller.isViewingOrder.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final orderData = controller.detailsList.value;
        if (orderData == null) {
          return Center(
            child: AppText(
              text: "No order details found",
              fontSize: 16,
              color: AppColors.instance.greyTextColor,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Information Container
              Container(
                width: AppSize.width(value: double.maxFinite),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  border: Border.all(color: AppColors.instance.authBorderColor),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: AppString.instance.orderDetails,
                      fontWeight: FontWeight.w500,
                      fontFamily: 1,
                      fontSize: 18,
                      color: AppColors.instance.textColor,
                    ),
                    Gap(height: 8),
                    _buildOrderDetailRow("Order ID", orderData.id ?? "N/A"),
                    Gap(height: 5),
                    _buildOrderDetailRow(
                      "Phone",
                      orderData.phoneNumber ?? "N/A",
                    ),
                    Gap(height: 5),
                    _buildOrderDetailRow(
                      "Address",
                      "${orderData.addressLine1 ?? ""} ${orderData.addressLine2 ?? ""}, ${orderData.city ?? ""}, ${orderData.stateCode ?? ""} ${orderData.postalCode ?? ""}",
                    ),
                    Gap(height: 5),
                    _buildOrderDetailRow(
                      "Order Date",
                      orderData.orderDate ?? "N/A",
                    ),
                    Gap(height: 5),
                    _buildOrderDetailRow("Status", orderData.status ?? "N/A"),
                    Gap(height: 5),
                    _buildOrderDetailRow(
                      "Payment Status",
                      orderData.paymentStatus ?? "N/A",
                    ),
                    Gap(height: 5),
                    _buildOrderDetailRow(
                      "Total Amount",
                      "\$${orderData.totalAmount ?? 0}",
                    ),
                  ],
                ),
              ),
              Gap(height: 30),

              // Products Header
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(color: AppColors.instance.grey200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppText(
                        text: "Item Name",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.instance.textColor,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppText(
                        text: "Qty",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.instance.textColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppText(
                        text: "Price",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColors.instance.textColor,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),

              // Products List
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: AppColors.instance.white),
                  child:
                      orderData.productList != null &&
                          orderData.productList!.isNotEmpty
                      ? ListView.separated(
                          itemCount: orderData.productList!.length,
                          separatorBuilder: (context, index) => Gap(height: 10),
                          itemBuilder: (context, index) {
                            final product = orderData.productList![index];
                            final productInfo = product.productId;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text:
                                              productInfo?.name ??
                                              "Unknown Product",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color: AppColors.instance.textColor,
                                          maxLines: 2,
                                        ),
                                        if (productInfo?.categoryName != null)
                                          AppText(
                                            text: productInfo!.categoryName!,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 9,
                                            color: AppColors
                                                .instance
                                                .greyTextColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppText(
                                      text: "${product.quantity ?? 0}",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.instance.greyTextColor,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: AppText(
                                      text: "\$${product.price ?? 0}",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: AppColors.instance.greyTextColor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: AppText(
                            text: "No products found",
                            fontSize: 14,
                            color: AppColors.instance.greyTextColor,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return AppText(
      text: "${AppString.instance.bullet}$label: $value",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.instance.greyTextColor,
      maxLines: 2,
    );
  }
}
