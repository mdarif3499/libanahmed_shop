import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';

class CreateOrderEditInformation extends StatefulWidget {
  const CreateOrderEditInformation({super.key});

  @override
  State<CreateOrderEditInformation> createState() =>
      _CreateOrderEditInformationState();
}

class _CreateOrderEditInformationState
    extends State<CreateOrderEditInformation> {
  String _countryFlag = "usa";
  final TextEditingController _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countryController.text = "U.S.A";
  }

  void _pickCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          _countryController.text = country.name;
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
          text: "Edit Information",
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
          children: [
            Gap(
              height: AppSize.height(value: 10),
            ),
            Image.asset(
              AppAssertImage.instance.checkoutPage,
              height: AppSize.height(value: 80),
              width: AppSize.width(value: 80),
            ),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("Zip Code", "Zip Code"),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("Street Number", "Street Number"),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("Street Code", "Street Code"),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("Phone Number", "Phone Number"),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("Locality", "Locality"),
            Gap(height: AppSize.height(value: 10)),
            editInfoTexField("City", "City"),
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
                  controller: _countryController,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            editInfoTexField("Address", "Address"),
            Gap(height: 20),
            AppButton(
              title: "Booking Order Now",
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.green500,
              height: AppSize.height(value: 64),
              onTap: () {
                Get.back();
              },
            ),
            Gap(height: 40),
          ],
        ),
      ),
    );
  }

  Widget editInfoTexField(String label, String hintText) {
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
          controller: TextEditingController(),
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
}
