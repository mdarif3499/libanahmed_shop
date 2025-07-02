import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserMenuPayment extends StatelessWidget {
  const UserMenuPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.paymentMethod,
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image.asset(AppAssertImage.instance.card),
            ),
            Gap(
              height: 10,
            ),
            _buildInputField(
              label: AppString.instance.userName,
              hintText: AppString.instance.userName,
            ),
            _buildInputField(
              label: AppString.instance.cardNumber,
              hintText: AppString.instance.cardNumber,
            ),
            _buildInputField(
              label: AppString.instance.expiryDate,
              hintText: AppString.instance.expiryDate,
            ),
            _buildInputField(
              label: AppString.instance.cvv,
              hintText: AppString.instance.cvv,
            ),
            AppButton(
              title: AppString.instance.changePaymentMethod,
              titleColor: AppColors.instance.white,
              backgroundColor: AppColors.instance.green500,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    bool isEmail = false,
    bool isPassWord = false,
    TextEditingController? isPassWordSecondValidationController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 1,
          color: AppColors.instance.greyColor,
        ),
        const Gap(height: 5),
        AppInputWidget(
          hintText: hintText,
          isEmail: isEmail,
          isPassWord: isPassWord,
          isPassWordSecondValidationController:
              isPassWordSecondValidationController,
          fillColor: AppColors.instance.white100,
          borderColor: AppColors.instance.authBorderColor,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: AppColors.instance.greyColor),
        ),
        const Gap(height: 10),
      ],
    );
  }
}
