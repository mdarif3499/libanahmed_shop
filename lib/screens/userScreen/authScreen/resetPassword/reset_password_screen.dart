import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/resetPassword/controller/reset_password_screen_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constant/app_assert_icons.dart';

class UserResetPassword extends StatelessWidget {
  const UserResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordScreenController controller =
        Get.put(ResetPasswordScreenController());
    return Scaffold(
      backgroundColor: AppColors.instance.userPhoneBackground,
      appBar: AppBar(
        backgroundColor: AppColors.instance.userPhoneBackground,
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
                text: AppString.instance.resetPassword,
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
              controller: controller.newPasswordController,
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
              controller: controller.confirmPasswordController,
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
              backgroundColor: AppColors.instance.green500,
              borderradius: 10,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
