import 'package:ahmed_shop/constant/app_assert_icons.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/cartHome/user_cart_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/user_home_screen.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/user_profile_screen.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/user_search_screen.dart';
import 'package:ahmed_shop/utils/app_size.dart';
import 'package:ahmed_shop/widgets/texts/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatefulWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  late int bottomNavIndex; // Use late to initialize in initState

  List<String> selectedText = [
    AppString.instance.home,
    AppString.instance.search,
    AppString.instance.cart,
    AppString.instance.userProfile,
  ];
  List<String> selectedIcon = [
    AppAssertIcons.uHomeSelected,
    AppAssertIcons.uSearchSelected,
    AppAssertIcons.uCartSelected,
    AppAssertIcons.uProfileSelected,
  ];
  List<String> unselectedIcon = [
    AppAssertIcons.uHome,
    AppAssertIcons.uSearch,
    AppAssertIcons.uCart,
    AppAssertIcons.uProfile,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize bottomNavIndex with the widget's currentIndex
    bottomNavIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      height: AppSize.height(value: 70),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 15),
        vertical: AppSize.height(value: 8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(value: 8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///==================== Icon ===================
                    SvgPicture.asset(
                      index == bottomNavIndex
                          ? selectedIcon[index]
                          : unselectedIcon[index],
                      height: 18,
                    ),

                    ///==================== Text ===================
                    AppText(
                      text: selectedText[index],
                      left: index == bottomNavIndex ? 4 : 0,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == bottomNavIndex) {
      return; // Prevent re-navigation to the same screen
    }

    // Update the selected index
    setState(() {
      bottomNavIndex = index;
    });

    // Navigate to the corresponding screen
    if (index == 0) {
      Get.offAll(() => UserHomeScreen(), transition: Transition.noTransition);
    } else if (index == 1) {
      Get.offAll(() => UserSearchScreen(), transition: Transition.noTransition);
    } else if (index == 2) {
      Get.offAll(() => UserCartScreen(), transition: Transition.noTransition);
    } else if (index == 3) {
      Get.offAll(() => UserProfileScreen(),
          transition: Transition.noTransition);
    }
  }
}
