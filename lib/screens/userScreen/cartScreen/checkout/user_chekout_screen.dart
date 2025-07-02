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
  String _countryFlag = "🇧🇩";

  @override
  void initState() {
    super.initState();
    controller.country.text = "Bangladesh";
  }

  void _pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          controller.country.text = country.name;
          _countryFlag = country.flagEmoji;
        });
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
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white50,
      ),
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(
              height: AppSize.height(value: 10),
            ),
            Center(
              child: Image.asset(
                AppAssertImage.instance.checkoutPage,
                height: AppSize.height(value: 80),
                width: AppSize.width(value: 80),
              ),
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField("Zip Code", "Zip Code", controller.zipCode,
                TextInputType.number),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField("Street Number", "Street Number",
                controller.streetName, TextInputType.streetAddress),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField("Street Code", "Street Code",
                controller.stateCode, TextInputType.streetAddress),
            Gap(height: AppSize.height(value: 10)),
            //!Phone Number
            AppText(
              text: AppString.instance.phoneNumber,
            ),
            Gap(height: AppSize.height(value: 5)),

            IntlPhoneFieldWidget(
              hintText: "enterYourPhoneNumber".tr,
              controller: controller.phoneNumber,
              onChanged: (phone) {
                controller.updatePhoneNumber(phone.completeNumber);
                log(phone.completeNumber);
              },
              fillColor: AppColors.instance.createOrderTextFiledFill,
              borderColor: AppColors.instance.createOrderTextFieldBorder,
              initialCountryCode: "BD",
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField("Locality", "Locality", controller.locality,
                TextInputType.streetAddress),
            Gap(height: AppSize.height(value: 10)),
            editInfoTextField("House Number", "House Number",
                controller.houseNumnber, TextInputType.streetAddress),
            Gap(height: AppSize.height(value: 10)),
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
                  controller: controller.country,
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
                      child: Text(
                        _countryFlag,
                        style: TextStyle(fontSize: 20),
                      ),
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
            editInfoTextField("Address", "Address", controller.address,
                TextInputType.streetAddress),
            Gap(height: 20),
            Obx(() => AppButton(
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
                )),
            Gap(
              height: AppSize.height(value: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget editInfoTextField(String label, String hintText,
      TextEditingController textController, TextInputType? keyboardtype) {
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
            contentPadding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
          ),
        ),
      ],
    );
  }

  void _submitOrder() {
    // Basic validation
    if (controller.zipCode.text.isEmpty ||
        controller.streetName.text.isEmpty ||
        controller.stateCode.text.isEmpty ||
        controller.phoneNumber.text.isEmpty ||
        controller.locality.text.isEmpty ||
        controller.houseNumnber.text.isEmpty ||
        controller.country.text.isEmpty ||
        controller.address.text.isEmpty) {
      AppSnackBar.error("Please fill all fields");
      return;
    }

    controller.orderCheckout(
      controller.zipCode.text,
      controller.streetName.text,
      controller.stateCode.text,
      controller.phoneNumber.text,
      controller.locality.text,
      controller.houseNumnber.text,
      controller.country.text,
      controller.address.text,
    );
  }
}
