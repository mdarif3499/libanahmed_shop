import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/utils/gap.dart';
import 'package:ahmed_shop/widgets/buttons/icon_app_button.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../widgets/app_aspect_ratio/app_aspect_ratio.dart';

class OwnerMenuOffer extends StatelessWidget {
  const OwnerMenuOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
      {
        'image': AppAssertImage.instance.strawberry,
        'title': AppString.instance.sweetStrawberries,
        'price': AppString.instance.eightNine,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: AppString.instance.offers,
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
        backgroundColor: AppColors.instance.white,
      ),
      backgroundColor: AppColors.instance.ownerPhoneBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            shrinkWrap: true,
            // Important to make the grid scrollable inside SingleChildScrollView
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: getResponsiveAspectRatio(context),
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                color: AppColors.instance.white,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          product['image']!,
                          height: AppSize.height(value: 94),
                          width: AppSize.width(value: 94),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gap(height: AppSize.height(value: 10)),
                      AppText(
                        text: product['title']!,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.instance.textColor,
                      ),
                      Gap(height: 5),
                      AppText(
                        text: product['price']!,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: AppColors.instance.textColor,
                      ),
                      Gap(height: AppSize.height(value: 10)),
                      IconAppButton(
                        height: AppSize.height(value: 40),
                        iconAlignment: CustomIconAlignment.right,
                        backgroundColor: AppColors.instance.red500,
                        title: AppString.instance.viewDetails,
                        icon: AppAssertIcons.userCartButton,
                        iconSize: 15,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
