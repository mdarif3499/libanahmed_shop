import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_log.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'controller/user_edit_profile_controller.dart';

class UserEditProfile extends StatelessWidget {
  const UserEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final UserEditProfileController controller =
        Get.put(UserEditProfileController());

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.editProfile,
          color: AppColors.instance.grey800,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Get.to(() => UserBottomNav(), arguments: 3);
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
            Gap(height: 30),
            // Replace your existing image display section with this:
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Display the profile image
                  Obx(() {
                    // Priority: 1. Selected new image, 2. Current profile image, 3. Default image
                    if (controller.selectedImage.value != null) {
                      // Show newly selected image
                      return CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            FileImage(controller.selectedImage.value!),
                      );
                    } else if (controller.currentImageUrl.value.isNotEmpty) {
                      // Show existing profile image from server
                      return CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            NetworkImage(controller.currentImageUrl.value),
                        onBackgroundImageError: (exception, stackTrace) {
                          // If network image fails to load, show default
                          appLog('Failed to load profile image: $exception');
                        },
                        child: controller.currentImageUrl.value.isEmpty
                            ? Image.asset(AppAssertImage.instance.profile,
                                fit: BoxFit.cover)
                            : null,
                      );
                    } else {
                      // Show default image
                      return CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            AssetImage(AppAssertImage.instance.profile),
                      );
                    }
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: InkWell(
                      onTap: controller.pickImage,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.instance.primary900,
                        child: Icon(
                          Icons.mode_edit_outline_outlined,
                          color: AppColors.instance.white100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(height: 30),
            AppText(
              text: AppString.instance.accountDetails,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.instance.textColor,
            ),
            Gap(height: 10),
            _buildInputField(
              label: AppString.instance.userName,
              controller: controller.userNameController,
              hintText: AppString.instance.hintName,
            ),
            _buildInputField(
              label: AppString.instance.address,
              controller: controller.addressController,
              hintText: AppString.instance.hintAddress,
            ),
            _buildInputField(
              label: AppString.instance.phoneNumber,
              controller: controller.phoneNumberController,
              hintText: AppString.instance.hintPhone,
              keyboardType: TextInputType.phone,
            ),
            Gap(height: 30),
            Obx(() {
              return SizedBox(
                height: AppSize.height(value: 50),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          await controller.updateProfile();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.instance.green500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.instance.white50,
                            ),
                          ),
                        )
                      : AppText(
                          text: AppString.instance.updateProfile,
                          color: AppColors.instance.white50,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType, // Make keyboardType optional
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.instance.greyColor,
        ),
        const Gap(height: 5),
        AppInputWidget(
          controller: controller,
          hintText: hintText,
          fillColor: AppColors.instance.white100,
          borderColor: AppColors.instance.authBorderColor,
          keyboardType: keyboardType, // Pass the optional keyboardType
          textInputAction: TextInputAction.done,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.instance.greyColor,
          ),
        ),
        const Gap(height: 10),
      ],
    );
  }
}
