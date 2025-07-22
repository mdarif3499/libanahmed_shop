import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/editProfile/controller/owner_edit_profile_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/app_image/app_image.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerEditProfile extends StatelessWidget {
  const OwnerEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerEditProfileController controller = Get.put(
      OwnerEditProfileController(),
    );
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
            Get.back();
          },
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
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
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Display the profile image
                  Obx(() {
                    // Priority: 1. Selected new image, 2. Current profile image, 3. Default image
                    if (controller.selectedImage.value != null) {
                      // Show newly selected image using AppImage
                      return AppImage(
                        filePath: controller.selectedImage.value!.path,
                        width: 160, // radius 80 * 2
                        height: 160,
                        fit: BoxFit.cover,
                        shape: ImageShape.circle,
                        color: Colors
                            .grey[300], // Background color for placeholder
                      );
                    } else if (controller.currentImageUrl.value.isNotEmpty) {
                      // Show existing profile image from server using AppImage
                      return AppImage(
                        url: controller.currentImageUrl.value,
                        width: 160, // radius 80 * 2
                        height: 160,
                        fit: BoxFit.cover,
                        shape: ImageShape.circle,
                        color: Colors
                            .grey[300], // Background color for placeholder
                      );
                    } else {
                      // Show default image using AppImage
                      return AppImage(
                        path: AppAssertImage.instance.profile,
                        width: 160, // radius 80 * 2
                        height: 160,
                        fit: BoxFit.cover,
                        shape: ImageShape.circle,
                        color: Colors
                            .grey[300], // Background color for placeholder
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
              label: AppString.instance.phoneNumber,
              controller: controller.phoneNumberController,
              hintText: AppString.instance.hintPhone,
            ),
            _buildInputField(
              label: "Address Line 1",
              controller: controller.addressLine1Controller,
              hintText: AppString.instance.hintAddress,
            ),
            _buildInputField(
              label: "Address Line 2",
              controller: controller.addressLine2Controller,
              hintText: AppString.instance.hintAddress,
            ),
            _buildInputField(
              label: "Enter Your City",
              controller: controller.cityController,
              hintText: AppString.instance.hintPhone,
            ),
            _buildInputField(
              label: "Enter Country Code",
              controller: controller.countryCodeController,
              hintText: AppString.instance.hintPhone,
            ),
            _buildInputField(
              label: "Enter Your State Code",
              controller: controller.stateCodeController,
              hintText: AppString.instance.hintPhone,
            ),
            _buildInputField(
              label: "Enter Your Zip Code",
              controller: controller.postalCodeController,
              hintText: AppString.instance.hintPhone,
            ),
            Gap(height: 30),
            AppButton(
              title: AppString.instance.updateProfile,
              onTap: controller.isLoading.value
                  ? null
                  : () async {
                      await controller.updateOwnerProfile();
                    },
              backgroundColor: AppColors.instance.red500,
              titleColor: AppColors.instance.white50,
              borderradius: 8,
              height: AppSize.height(value: 50),
            ),
            Gap(height: AppSize.height(value: 50)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
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
          keyboardType: TextInputType.text,
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
