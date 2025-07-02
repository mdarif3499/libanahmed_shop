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

import '../../../../widgets/inputs/app_input_widget_three.dart';

class UserCustomerService extends StatelessWidget {
  const UserCustomerService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.ratings,
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
            AppText(
              text: AppString.instance.writeDownProblem,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.instance.white900,
            ),
            Gap(
              height: 10,
            ),
            AppInputReview(
              hintText: "Write a review here...",
              fillColor: AppColors.instance.white50, // Custom fill color
              borderColor: AppColors.instance.grey300, // Custom border color
              controller: TextEditingController(),
            ),
            Gap(
              height: 20,
            ),
            AppButton(
              backgroundColor: AppColors.instance.green500,
              titleColor: AppColors.instance.white50,
              title: AppString.instance.sentMessage,
              onTap: () {},
              height: AppSize.height(value: 52),
            ),
            Gap(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
