import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/createAccount/controller/user_create_account_controller.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/app_button.dart';
import 'package:ahmed_shop/widgets/buttons/app_button_row.dart';
import 'package:ahmed_shop/widgets/inputs/app_input_widget.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateAccountScreenUser extends StatelessWidget {
  const CreateAccountScreenUser({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX
    final controller = Get.put(CreateAccountController());

    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments["isLogin"] == true) {
      controller.isLogin.value = true;
    }

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
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(height: 50),
              Center(
                child: AppText(
                  text: AppString.instance.createAccount,
                  fontFamily: 2,
                  fontWeight: FontWeight.w700,
                  fontSize: 33,
                ),
              ),
              const Gap(height: 25),

              // Toggle Buttons
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.instance.authBorderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // SignUp Button
                    Obx(() {
                      return Expanded(
                        child: AppButton(
                          onTap: () {
                            if (!controller.isLogin.value) {
                              return; // Do nothing if already on sign-up screen
                            }
                            controller.isLogin.value = false;
                          },
                          title: AppString.instance.signUp,
                          backgroundColor: !controller.isLogin.value
                              ? AppColors.instance.white100
                              : AppColors.instance.conInactive,
                          titleColor: !controller.isLogin.value
                              ? AppColors.instance.dark900
                              : AppColors.instance.textFieldTextColor,
                          borderradius: 8,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      );
                    }),

                    const Gap(width: 10),

                    // Login Button
                    Obx(() {
                      return Expanded(
                        child: AppButton(
                          onTap: () {
                            if (controller.isLogin.value) {
                              return;
                            }
                            controller.isLogin.value = true; // Show Login Form
                          },
                          title: AppString.instance.login,
                          backgroundColor: controller.isLogin.value
                              ? AppColors.instance.white100
                              : AppColors.instance.conInactive,
                          titleColor: controller.isLogin.value
                              ? AppColors.instance.dark900
                              : AppColors.instance.textFieldTextColor,
                          borderradius: 8,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const Gap(height: 20),

              /// Sign Up Fields
              Obx(() {
                if (!controller.isLogin.value) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        label: AppString.instance.firstName,
                        controller: controller.firstNameController,
                        hintText: AppString.instance.hintName,
                      ),
                      _buildInputField(
                        label: AppString.instance.lasName,
                        controller: controller.lastNameController,
                        hintText: AppString.instance.hintName,
                      ),
                      _buildInputField(
                        label: AppString.instance.email,
                        controller: controller.emailController,
                        hintText: AppString.instance.hintEmail,
                        isEmail: true,
                      ),
                      _buildInputField(
                        label: AppString.instance.setPassword,
                        controller: controller.passwordController,
                        hintText: AppString.instance.hintPassword,
                        isPassWord: true,
                      ),
                      _buildInputField(
                        label: AppString.instance.confirmPassword,
                        controller: controller.confirmPasswordController,
                        hintText: AppString.instance.hintPassword,
                        isPassWord: true,
                        isPassWordSecondValidationController:
                            controller.passwordController,
                      ),
                      const Gap(height: 32),
                      // Dart
                      AppButton(
                        onTap: () {
                          if (controller.formKey.currentState?.validate() ??
                              false) {
                            controller
                                .registerUser(); // Call the registration method
                          }
                        },
                        title: controller.isLoading.value
                            ? "Registering..."
                            : AppString.instance.signUp,
                        titleColor: AppColors.instance.white100,
                        backgroundColor: AppColors.instance.green500,
                        borderradius: 10,
                        isLoading: controller
                            .isLoading
                            .value, // Show loading indicator
                      ),
                      const Gap(height: 20),
                    ],
                  );
                } else {
                  // Login Fields
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        label: AppString.instance.email,
                        controller: controller.emailController,
                        hintText: AppString.instance.hintEmail,
                        isEmail: true,
                      ),
                      _buildInputField(
                        label: AppString.instance.password,
                        controller: controller.passwordController,
                        hintText: AppString.instance.password,
                        isPassWord: true,
                      ),
                      const Gap(height: 10),
                      Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: controller.isRememberMeChecked.value,
                              onChanged: (bool? value) {
                                controller.toggleRememberMe(value);
                              },
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                (Set<WidgetState> states) {
                                  if (controller.isRememberMeChecked.value) {
                                    return AppColors.instance.green500;
                                  }
                                  // Otherwise, keep the background transparent
                                  return Colors.transparent;
                                },
                              ),
                              checkColor: Colors.white,
                              // Check mark will be white
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, // This prevents excess padding around the checkbox
                            );
                          }),
                          AppText(
                            text: AppString.instance.rememberMe,
                            fontSize: 12,
                            fontFamily: 1,
                            fontWeight: FontWeight.w500,
                            color: AppColors.instance.greyColor,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.forgotPassword);
                            },
                            child: AppText(
                              text: AppString.instance.forgotPassword,
                              fontWeight: FontWeight.w500,
                              fontFamily: 1,
                              fontSize: 12,
                              color: AppColors.instance.green500,
                            ),
                          ),
                        ],
                      ),
                      const Gap(height: 32),
                      Obx(() {
                        return AppButton(
                          onTap: () {
                            if (!controller.isLoading.value) {
                              controller.loginUser();
                            }
                          },
                          title: controller.isLoading.value
                              ? "Logging in..."
                              : AppString.instance.login,
                          titleColor: AppColors.instance.white100,
                          backgroundColor: AppColors.instance.green500,
                          borderradius: 10,
                          height: AppSize.height(value: 50),
                          isLoading: controller
                              .isLoading
                              .value, // Show loading indicator
                        );
                      }),
                      Gap(height: 18),
                      Center(
                        child: AppText(
                          text: AppString.instance.continueAsGuest,
                          fontSize: 16,
                          fontFamily: 2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.instance.blue2_500,
                        ),
                      ),
                      Gap(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.instance.authBorderColor,
                            ),
                          ),
                          Gap(width: 3),
                          AppText(
                            text: "0r",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.instance.greyColor,
                            fontFamily: 2,
                          ),
                          Gap(width: 3),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: AppColors.instance.authBorderColor,
                            ),
                          ),
                        ],
                      ),
                      Gap(height: 18),
                      AppImageButton(
                        height: AppSize.height(value: 50),
                        imagePosition: ImagePosition.left,
                        svgPath: AppAssertIcons.google,
                        title: AppString.instance.signUpWithGoogle,
                        fontSize: 14,
                        backgroundColor: AppColors.instance.white100,
                        borderColor: AppColors.instance.authBorderColor,
                        titleColor: AppColors.instance.black900,
                      ),
                      Gap(height: 18),
                      AppImageButton(
                        height: AppSize.height(value: 50),
                        imagePosition: ImagePosition.left,
                        svgPath: AppAssertIcons.apple,
                        title: AppString.instance.signUpWithApple,
                        fontSize: 14,
                        backgroundColor: AppColors.instance.white100,
                        borderColor: AppColors.instance.authBorderColor,
                        titleColor: AppColors.instance.black900,
                      ),
                      Gap(height: 18),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
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
          controller: controller,
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
            color: AppColors.instance.greyColor,
          ),
        ),
        const Gap(height: 10),
      ],
    );
  }
}
