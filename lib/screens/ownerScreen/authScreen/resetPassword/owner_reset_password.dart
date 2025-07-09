import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/resetPassword/controller/owner_reset_password_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OwnerResetPassword extends StatelessWidget {
  OwnerResetPassword({super.key});
  final OwnerResetPasswordController controller =
      Get.put(OwnerResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      appBar: AppBar(
        backgroundColor: AppColors.instance.ownerPhoneBackground,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        title: AppText(
          text: AppString.instance.back,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 1,
        ),
        titleSpacing: -7,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppText(
                text: AppString.instance.otpVerification,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 2,
              ),
            ),
            Gap(height: 15),
            Center(
              child: AppText(
                text: AppString.instance.provideYourEmail,
                fontFamily: 2,
                fontSize: 12,
                color: AppColors.instance.greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(height: 15),
            AppText(
              text: AppString.instance.password,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 1,
              color: AppColors.instance.greyColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              hintText: AppString.instance.hintPassword,
              isEmail: false,
              isPassWord: true,
              fillColor: AppColors.instance.white100,
              borderColor: AppColors.instance.authBorderColor,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.instance.greyColor),
            ),
            Gap(height: 15),
            AppText(
              text: AppString.instance.rewritePassword,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 1,
              color: AppColors.instance.greyColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              hintText: AppString.instance.hintPassword,
              isEmail: false,
              isPassWord: true,
              fillColor: AppColors.instance.white100,
              borderColor: AppColors.instance.authBorderColor,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.instance.greyColor),
            ),
            Gap(
              height: 25,
            ),
            AppButton(
              title: AppString.instance.reset,
              onTap: () {
                controller.resetPassword();
              },
              backgroundColor: AppColors.instance.red500,
              borderradius: 10,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
