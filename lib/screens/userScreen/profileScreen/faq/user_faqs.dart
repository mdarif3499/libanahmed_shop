import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/user_bottom_navigation.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserFaqsScreen extends StatelessWidget {
  const UserFaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.faqs,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => UserNavigationScreen(), arguments: 3);
          },
          icon: SvgPicture.asset(
            AppAssertIcons.backIcon,
          ),
        ),
        backgroundColor: AppColors.instance.white50,
      ),
      backgroundColor: AppColors.instance.userPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            AppText(
              text: AppString.instance.paragraphOne,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.instance.textColor,
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
            Gap(
              height: 12,
            ),
            AppText(
              text: AppString.instance.paragraphTwo,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.instance.textColor,
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
            Gap(
              height: 12,
            ),
            AppText(
              text: AppString.instance.paragraphThree,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.instance.textColor,
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
