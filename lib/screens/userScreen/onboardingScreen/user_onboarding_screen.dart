import 'package:ahmed_shop/constant/app_assert_image.dart';
import 'package:ahmed_shop/constant/app_colors.dart';
import 'package:ahmed_shop/constant/app_string.dart';
import 'package:ahmed_shop/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../widgets/texts/app_text.dart';

class UserOnboardingScreen extends StatefulWidget {
  const UserOnboardingScreen({super.key});

  @override
  _UserOnboardingScreenState createState() => _UserOnboardingScreenState();
}

class _UserOnboardingScreenState extends State<UserOnboardingScreen> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  // Initialize GetStorage instance
  final GetStorage _storage = GetStorage();

  List<String> paragraphs = [
    AppString.instance.joinOurApp,
    AppString.instance.whyChooseUs,
    AppString.instance.joinOurApp,
  ];

  void _nextPage() async {
    if (currentPage < paragraphs.length - 1) {
      setState(() {
        currentPage++;
      });
      _pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Store the onboarding completion state in GetStorage
      await _storage.write('user_onboarding_complete', true);
      Get.toNamed(AppRoutes.onboardScreenTwo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            AppAssertImage.instance.onboard,
            fit: BoxFit.cover,
          ),
          // Content overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.instance.white100.withAlpha(230),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AppText(
                          text: AppString.instance.whyChooseUs,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          fontFamily: 1,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Use PageView for smooth paragraph transitions
                      SizedBox(
                        height: 120, // Adjust this height as needed
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: paragraphs.length,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: AppText(
                                  text: paragraphs[index],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  maxLines: 5,
                                  textAlign: TextAlign.justify,
                                  color: AppColors.instance.textColor,
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                  // Skip and Next buttons - Using custom button instead of AppButton
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigate to the next screen directly
                            Get.to(() => HomePage());
                          },
                          child: AppText(
                            text: AppString.instance.skip,
                            fontFamily: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppColors.instance.textColor,
                          ),
                        ),
                        // Custom button instead of AppButton
                        InkWell(
                          onTap: _nextPage,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.instance.green500,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppText(
                              text: AppString.instance.next,
                              fontFamily: 1,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColors.instance.white100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pagination Dots - Fixed with constraints
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity, // Use full width of parent
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Important
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(paragraphs.length, (index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 8,
                            width: 32,
                            decoration: BoxDecoration(
                                color: currentPage == index
                                    ? AppColors.instance.fillIndicator
                                    : AppColors.instance.nonFill,
                                borderRadius: BorderRadius.circular(20)),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}
