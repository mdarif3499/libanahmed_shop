import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/storeVefication/controller/owner_store_verification_controller.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OwnerStoreVerification extends StatelessWidget {
  const OwnerStoreVerification({super.key});

  @override
  Widget build(BuildContext context) {
    // Get controller instance
    final controller =
        Get.put(OwnerStoreVerificationController(), permanent: true);

    return Scaffold(
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      appBar: AppBar(
        backgroundColor: AppColors.instance.ownerPhoneBackground,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppAssertIcons.backIcon),
        ),
        title: AppText(
          text: AppString.instance.verfication,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 1,
        ),
        titleSpacing: -7,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kToolbarHeight, // Ensure minimum height for full screen
          ),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: AppString.instance.storeInfo,
                  color: AppColors.instance.red500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 1,
                ),
                const Gap(height: 10),

                // Store Name Input
                _buildInputField(
                  label: AppString.instance.storeName,
                  hintText: AppString.instance.storeName,
                  textEditingController: controller.storeNameController,
                  validator: controller.validateStoreName,
                ),

                // Store Description Input
                _buildInputField(
                  label: AppString.instance.storeVerification,
                  hintText: AppString.instance.storeVerification,
                  textEditingController: controller.storeDescriptionController,
                  validator: controller.validateStoreDescription,
                  maxLines: 3,
                ),
                // Store Images Section
                AppText(
                  text: AppString.instance.storeImage,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 1,
                  color: AppColors.instance.textColor,
                ),
                const Gap(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.instance.white50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.instance.authBorderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () =>
                            controller.showStoreImageSourceDialog(context),
                        icon: SvgPicture.asset(
                          AppAssertIcons.imageLogo,
                          height: 35,
                          width: 35,
                          colorFilter: ColorFilter.mode(
                            AppColors.instance.textColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Gap(height: 10),

                      // Display selected store images
                      Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.storeImageNames.isEmpty
                                ? 1
                                : controller.storeImageNames.length,
                            itemBuilder: (context, index) {
                              if (controller.storeImageNames.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: AppText(
                                    text: "No store images selected",
                                    fontFamily: 2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.instance.greyColor,
                                  ),
                                );
                              }
                              final imageName =
                                  controller.storeImageNames[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.instance.white50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.instance.authBorderColor
                                        .withAlpha(78),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.store,
                                      size: 16,
                                      color: AppColors.instance.textColor
                                          .withAlpha(134),
                                    ),
                                    const Gap(width: 8),
                                    Expanded(
                                      child: AppText(
                                        text: imageName,
                                        fontFamily: 2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          controller.removeStoreImage(index),
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: AppColors.instance.red500,
                                      ),
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
                const Gap(height: 10),

                // Store License Section
                AppText(
                  text: AppString.instance.storeLicense,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 1,
                  color: AppColors.instance.textColor,
                ),
                const Gap(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.instance.white50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.instance.authBorderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () =>
                            controller.showDocumentImageSourceDialog(context),
                        icon: SvgPicture.asset(
                          AppAssertIcons.uploadDocument,
                          height: 35,
                          width: 35,
                          colorFilter: ColorFilter.mode(
                            AppColors.instance.textColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const Gap(height: 10),

                      // Display selected document images
                      Obx(() => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.documentImageNames.isEmpty
                                ? 1
                                : controller.documentImageNames.length,
                            itemBuilder: (context, index) {
                              if (controller.documentImageNames.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: AppText(
                                    text: "No document images selected",
                                    fontFamily: 2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColors.instance.greyColor,
                                  ),
                                );
                              }
                              final fileName =
                                  controller.documentImageNames[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.instance.white50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.instance.authBorderColor
                                        .withAlpha(78),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.document_scanner,
                                      size: 16,
                                      color: AppColors.instance.textColor
                                          .withAlpha(137),
                                    ),
                                    const Gap(width: 8),
                                    Expanded(
                                      child: AppText(
                                        text: fileName,
                                        fontFamily: 2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          controller.removeDocumentImage(index),
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: AppColors.instance.red500,
                                      ),
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
                const Gap(height: 15),

                // Submit Button
                Obx(() => AppButton(
                      title: controller.isLoading.value
                          ? "Submitting..."
                          : AppString.instance.submitToVerify,
                      titleColor: AppColors.instance.white50,
                      onTap: controller.isLoading.value
                          ? null
                          : controller.submitStoreVerification,
                      backgroundColor: controller.isFormValid.value &&
                              !controller.isLoading.value
                          ? AppColors.instance.red500
                          : AppColors.instance.greyColor,
                      height: 48,
                    )),
                const Gap(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildInputField({
  required String label,
  required String hintText,
  bool isEmail = false,
  bool isPassWord = false,
  TextEditingController? textEditingController,
  String? Function(String?)? validator,
  int maxLines = 1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        text: label,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 1,
        color: AppColors.instance.textColor,
      ),
      const Gap(height: 5),
      AppInputWidget(
        controller: textEditingController,
        hintText: hintText,
        isEmail: isEmail,
        isPassWord: isPassWord,
        fillColor: AppColors.instance.white50,
        borderColor: AppColors.instance.authBorderColor,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : maxLines > 1
                ? TextInputType.multiline
                : TextInputType.text,
        textInputAction:
            maxLines > 1 ? TextInputAction.newline : TextInputAction.done,
        maxLines: maxLines,
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
