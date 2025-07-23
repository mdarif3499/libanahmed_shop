import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/user_bottom_navigation.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/controller/user_profile_settings_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class UserPrivacyPolicyScreen extends StatelessWidget {
  const UserPrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final UserProfileSettingsController controller =
        Get.put(UserProfileSettingsController());
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.privacyPolicy,
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
      body: Obx(() {
        // Check if the controller is loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Check if there was an error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: controller.errorMessage.value,
                  color: AppColors.instance.red300,
                  fontSize: 16,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.refreshSettings(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        // Check if settings data is available
        if (controller.settings.value == null ||
            controller.settings.value!.data == null) {
          return const Center(
              child: AppText(text: 'No data available', fontSize: 16));
        }
        // Display the terms and conditions
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Gap(height: AppSize.height(value: 20)),
              HtmlWidget(
                controller.settings.value!.data!.privacyPolicy ??
                    'No terms available',
                textStyle: TextStyle(
                  color: AppColors.instance.dark400,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(height: AppSize.height(value: 20)),
            ],
          ),
        );
      }),
    );
  }
}
