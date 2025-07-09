import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/forgotPassword/controller/owner_forgor_password_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerForgotPassword extends StatelessWidget {
  const OwnerForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerForgorPasswordController controller =
        Get.put(OwnerForgorPasswordController());
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AppText(
                text: AppString.instance.forgotPassword,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 2,
              ),
            ),
            Gap(
              height: 10,
            ),
            Center(
              child: AppText(
                text: AppString.instance.provideYourEmail,
                fontFamily: 2,
                fontSize: 12,
                color: AppColors.instance.greyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(
              height: 20,
            ),
            AppText(
              text: AppString.instance.email,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 1,
              color: AppColors.instance.greyColor,
            ),
            Gap(
              height: 10,
            ),
            AppInputWidget(
              controller: controller.emailController,
              hintText: AppString.instance.hintEmail,
              isEmail: true,
              fillColor: AppColors.instance.white100,
              borderColor: AppColors.instance.authBorderColor,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.instance.greyColor),
            ),
            Gap(
              height: 20,
            ),
            Obx(() {
              return AppButton(
                title: controller.isLoading.value ? "Sending..." : "Send Email",
                onTap: controller.isLoading.value
                    ? null
                    : () {
                        controller.forgotPassword();
                      },
                backgroundColor: AppColors.instance.red500,
                borderradius: 10,
                height: 50,
              );
            }),
          ],
        ),
      ),
    );
  }
}
