import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewarrivalsScreen extends StatelessWidget {
  const NewarrivalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.newArrivals,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: List.generate(6, (index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                color: AppColors.instance.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Same border radius as Container
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: AppString.instance.bestChoice,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: 2,
                            color: AppColors.instance.red500,
                          ),
                          Gap(height: AppSize.height(value: 05)),
                          AppText(
                            text: AppString.instance.sweetStrawberries,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 2,
                            color: AppColors.instance.textColor,
                          ),
                          Gap(height: AppSize.height(value: 05)),
                          AppText(
                            text: AppString.instance.perUnit,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 2,
                            color: AppColors.instance.textColor,
                          ),
                        ],
                      ),
                      Image.asset(
                        AppAssertImage.instance.strawberry,
                        height: AppSize.height(value: 80),
                        width: AppSize.width(value: 80),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
