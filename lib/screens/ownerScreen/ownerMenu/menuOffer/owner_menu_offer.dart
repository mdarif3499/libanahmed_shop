import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/inputs/app_input_widget.dart';
import 'controller/owner_create_offer_controller.dart';

class OwnerMenuOffer extends StatelessWidget {
  const OwnerMenuOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OwnerCreateOfferController());
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.offers,
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
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selected Product Display
              Obx(
                () => controller.selectedProductName.value.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Selected Product",
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 2,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: AppSize.height(value: 10)),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.instance.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.instance.authBorderColor,
                              ),
                            ),
                            child: AppText(
                              text: controller.selectedProductName.value,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.instance.textColor,
                            ),
                          ),
                          Gap(height: AppSize.height(value: 20)),
                        ],
                      )
                    : Container(),
              ),

              // Product Selection Dropdown
              AppText(
                text: "Select Product to Create Offer",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.instance.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.instance.authBorderColor),
                ),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedProduct.value?.sId,
                      hint: AppText(
                        text: controller.selectedProductName.value.isEmpty
                            ? "Select Product"
                            : controller.selectedProductName.value,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.instance.textColor.withAlpha(155),
                      ),
                      isExpanded: true,
                      items: controller.offerProductList.value?.data?.map((
                        product,
                      ) {
                        return DropdownMenuItem<String>(
                          value: product.sId,
                          child: AppText(
                            text: product.name ?? "Unknown Product",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.textColor,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? productId) {
                        if (productId != null) {
                          var selectedProduct = controller
                              .offerProductList
                              .value
                              ?.data
                              ?.firstWhere(
                                (product) => product.sId == productId,
                              );
                          if (selectedProduct != null) {
                            controller.setSelectedProduct(selectedProduct);
                          }
                        }
                      },
                    ),
                  );
                }),
              ),

              Gap(height: AppSize.height(value: 20)),

              // Offer Percentage Input
              AppText(
                text: "Type Offer Percentage",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              AppInputWidget(
                controller: controller.offerPercent,
                fillColor: AppColors.instance.white,
                borderColor: AppColors.instance.authBorderColor,
                hintText: "Enter offer percentage (1-100)",
                keyboardType: TextInputType.number,
              ),

              Gap(height: AppSize.height(value: 20)),

              // Start Date Selection
              AppText(
                text: "Offer Start Date",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    controller.setStartDate(picked);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.instance.authBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(
                          () => AppText(
                            text: controller.startingDateText.value.isEmpty
                                ? "Select start date"
                                : controller.startingDateText.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: controller.startingDateText.value.isEmpty
                                ? AppColors.instance.textColor.withAlpha(155)
                                : AppColors.instance.textColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.instance.textColor.withAlpha(155),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(height: AppSize.height(value: 20)),

              // End Date Selection
              AppText(
                text: "Offer End Date",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: 2,
                color: AppColors.instance.textColor,
              ),
              Gap(height: AppSize.height(value: 10)),
              GestureDetector(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedStartDate ?? DateTime.now(),
                    firstDate: controller.selectedStartDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    controller.setEndDate(picked);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.instance.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.instance.authBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(
                          () => AppText(
                            text: controller.endingDateText.value.isEmpty
                                ? "Select end date"
                                : controller.endingDateText.value,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: controller.endingDateText.value.isEmpty
                                ? AppColors.instance.textColor.withAlpha(155)
                                : AppColors.instance.textColor,
                          ),
                        ),
                      ),
                      Gap(width: 8),
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.instance.textColor.withAlpha(155),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(height: AppSize.height(value: 40)),

              // Create Offer Button
              AppButton(
                title: controller.isCreatingOffer.value
                    ? "Creating Offer..."
                    : "Create Offer",
                onTap: controller.isCreatingOffer.value
                    ? null
                    : () => controller.createOffer(),
                backgroundColor: AppColors.instance.red500,
                titleColor: AppColors.instance.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
