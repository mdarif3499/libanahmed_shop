import 'dart:developer';

import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/checkout/controller/user_checkout_contoller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_intl_phone_field/app_intl_phone_field.dart';
import 'package:ahmed_shop/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class UserCheckoutScreen extends StatefulWidget {
  const UserCheckoutScreen({super.key});

  @override
  State<UserCheckoutScreen> createState() => _UserCheckoutScreenState();
}

class _UserCheckoutScreenState extends State<UserCheckoutScreen> {
  final UserCheckoutContoller controller = Get.put(UserCheckoutContoller());
  String _countryFlag = "🇺🇸"; // USA flag emoji
  String _selectedCountryCode =
      "US"; // This will store the actual country code like "BD", "US"

  @override
  void initState() {
    super.initState();
    controller.countryCode.text =
        "United States"; // Set initial country to USA (for display)
    _selectedCountryCode = "US"; // Set initial country code (for API)
  }

  void _pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          controller.countryCode.text =
              country.countryCode; // Store name for display
          _countryFlag = country.flagEmoji;
          _selectedCountryCode = country.countryCode;
        });

        // Debug log
        log(
          "Selected Country Code: $_selectedCountryCode",
        ); // This will be "BD", "US", etc.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.createOrder,
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
        backgroundColor: AppColors.instance.white50,
      ),
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(height: AppSize.height(value: 10)),
            Center(
              child: Image.asset(
                AppAssertImage.instance.checkoutPage,
                height: AppSize.height(value: 80),
                width: AppSize.width(value: 80),
              ),
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField(
              "Postal Code",
              "Enter Postal Code",
              controller.postalCode,
              TextInputType.number,
            ),
            //!Phone Number
            AppText(text: AppString.instance.phoneNumber),
            Gap(height: AppSize.height(value: 5)),
            IntlPhoneFieldWidget(
              hintText: "Enter Your Number".tr,
              controller: controller.phoneNumber,
              onChanged: (phone) {
                controller.updatePhoneNumber(phone.completeNumber);
                log(phone.completeNumber);
              },
              fillColor: AppColors.instance.createOrderTextFiledFill,
              borderColor: AppColors.instance.createOrderTextFieldBorder,
              initialCountryCode: "US", // Set initial country code to USA
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField(
              "State Code",
              "Enter your state code",
              controller.stateCode,
              TextInputType.streetAddress,
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField(
              "City",
              "Enter your city",
              controller.cityName,
              TextInputType.streetAddress,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Country",
                  fontFamily: 2,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.instance.textColor,
                ),
                Gap(height: AppSize.height(value: 5)),
                TextFormField(
                  controller: controller.countryCode,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Country",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.instance.createOrderTextFieldBorder,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.instance.createOrderTextFiledFill,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(_countryFlag, style: TextStyle(fontSize: 20)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                  ),
                  onTap: () => _pickCountry(context),
                ),
              ],
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField(
              "Address 1",
              "Enter Your Address 1",
              controller.addressLine1,
              TextInputType.streetAddress,
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField(
              "Address 2",
              "Enter Your Address 2",
              controller.addressLine2,
              TextInputType.streetAddress,
            ),
            Gap(height: AppSize.height(value: 10)),

            Gap(height: 20),
            Obx(
              () => AppButton(
                title: controller.isCheckOutCompleted.value
                    ? "Processing..."
                    : "Booking Order Now",
                titleColor: AppColors.instance.white,
                backgroundColor: controller.isCheckOutCompleted.value
                    ? AppColors.instance.grey500
                    : AppColors.instance.green500,
                height: AppSize.height(value: 64),
                onTap: controller.isCheckOutCompleted.value
                    ? null
                    : () {
                        _submitOrder();
                      },
              ),
            ),
            Gap(height: AppSize.height(value: 40)),
          ],
        ),
      ),
    );
  }

  Widget editInfoTextField(
    String label,
    String hintText,
    TextEditingController textController,
    TextInputType? keyboardtype,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          fontFamily: 2,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.instance.textColor,
        ),
        Gap(height: AppSize.height(value: 5)),
        TextFormField(
          controller: textController,
          keyboardType: keyboardtype,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.instance.createOrderTextFieldBorder,
              ),
            ),
            filled: true,
            fillColor: AppColors.instance.createOrderTextFiledFill,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
      ],
    );
  }

  void _submitOrder() {
    // Basic validation
    if (controller.postalCode.text.isEmpty ||
        controller.phoneNumber.text.isEmpty ||
        controller.stateCode.text.isEmpty ||
        controller.cityName.text.isEmpty ||
        controller.countryCode.text.isEmpty ||
        controller.addressLine1.text.isEmpty ||
        controller.addressLine2.text.isEmpty) {
      AppSnackBar.error("Please fill all fields");
      return;
    }

    // Log to verify what we're sending
    log("Country Name (Display): ${controller.countryCode.text}");
    log("Country Code (API): $_selectedCountryCode");

    controller.orderCheckout(
      controller.postalCode.text,
      controller.addressLine1.text,
      controller.stateCode.text,
      controller.phoneNumber.text,
      controller.cityName.text,
      controller.addressLine2.text,
      _selectedCountryCode, // Send the actual country code: "BD", "US", etc.
      "${controller.addressLine1.text}, ${controller.addressLine2.text}",
    );
  }
}
