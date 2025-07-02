import 'package:ahmed_shop/screens/ownerScreen/authScreen/createAccount/owner_create%20account.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/forgotPassword/owner_forgot_password.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/forgot_password_otp/owner_forgot_password_otp_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/otpVerification/owner_otp_verification.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/resetPassword/owner_reset_password.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/shop_owner_otp_verification_screen/shop_owner_otp_verification_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/authScreen/storeVefication/owner_store_verification.dart';
import 'package:ahmed_shop/screens/ownerScreen/bottomNav/owner_bottom_nav.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/addNewProduct/owner_add_new_product.dart';
import 'package:ahmed_shop/screens/ownerScreen/myShopScreen/viewProductDetails/owner_edit_product.dart';
import 'package:ahmed_shop/screens/ownerScreen/onboardingScreen/owner_onboarding_screen.dart';
import 'package:ahmed_shop/screens/ownerScreen/orderScreen/orderProgress/owner_order_progress.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuBestSelling/owner_menu_best_selling_items.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuCancelledOrders/owner_menu_cancelled_items.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuOffer/owner_menu_offer.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuPaymentOption/owner_menu_payment_option.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuRatings/owner_menu_ratings.dart';
import 'package:ahmed_shop/screens/ownerScreen/ownerMenu/menuTransection/owner_menu_transection.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/aboutUs/owner_about_us.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/contactSupport/owner_contact_support.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/faq/owner_faqs.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/privacyPolicy/owner_privacy_policy.dart';
import 'package:ahmed_shop/screens/ownerScreen/profileScreen/termsNcondition/owner_terms_and_condition.dart';
import 'package:ahmed_shop/screens/splashScreen/user_splash_screen.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/createAccount/create_account_screen_user.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/forgotPassword/user_forgot_password_screen.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/forgot_password_otp/forgot_password_otp_screen.dart';
import 'package:ahmed_shop/screens/userScreen/authScreen/otpVerification/user_otp_verification_screen.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/user_bottom_nav.dart';
import 'package:ahmed_shop/screens/userScreen/bottomNav/user_bottom_navigation.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/checkout/edit_information/edit_information.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/checkout/user_chekout_screen.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/orderProgress/user_order_progress.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/trackOrder/user_track_order.dart';
import 'package:ahmed_shop/screens/userScreen/cartScreen/viewOrder/user_view_order.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/categories/categories_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/mainHome/user_home_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/newArrivals/newArrivals_screen.dart';
import 'package:ahmed_shop/screens/userScreen/homeScreen/popularItems/popularItem_screen.dart';
import 'package:ahmed_shop/screens/userScreen/onboardingScreen/user_onboarding_screen.dart';
import 'package:ahmed_shop/screens/userScreen/onboardingScreen/user_onboarding_screen_two.dart';
import 'package:ahmed_shop/screens/userScreen/productsDetailsScreen/user_product_details_screen.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/aboutUs/user_about_us.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/contactSupport/user_contact_support.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/editProfile/user_edit_profile.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/faq/user_faqs.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/privacyPolicy/user_privacy_policy.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/profileHome/user_profile_screen.dart';
import 'package:ahmed_shop/screens/userScreen/profileScreen/termsNconditon/user_terms_and_condition.dart';
import 'package:ahmed_shop/screens/userScreen/searchScreen/user_search_screen.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuCustomerService/user_customer_service.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuFavourite/user_manu_favourite.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuOffer/user_menu_offer.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuPaymentOption/user_menu_payment.dart';
import 'package:ahmed_shop/screens/userScreen/userMenu/menuRatings/user_menu_ratings.dart';
import 'package:get/get.dart';

import '../screens/userScreen/authScreen/resetPassword/reset_password_screen.dart';
import '../screens/userScreen/authScreen/user_registration_otp_varification_screen/user_registration_otp_verfication_screen.dart';
import 'app_routes.dart';
import 'bindings/app_initial_bindings.dart';

List<GetPage> appRoutesFile = <GetPage>[
  ///Initial Page
  GetPage(
    name: AppRoutes.initial,
    page: () => const UserSplashScreen(),
    transition: Transition.fadeIn,
    binding: AppInitialBindings(),
    // middlewares: [InternetCheckMiddleWare()],
  ),

  // Splash Screen
  GetPage(
    name: AppRoutes.onboardScreen,
    page: () => const UserOnboardingScreen(),
    transition: Transition.fadeIn,
    binding: AppInitialBindings(),
    // middlewares: [InternetCheckMiddleWare()],
  ),

  GetPage(
    name: AppRoutes.onboardScreenTwo,
    page: (() => const UserOnboardingScreenTwo()),
    transition: Transition.fadeIn,
    binding: AppInitialBindings(),
    //  middlewares: [InternetCheckMiddleWare()],
  ),
  //Create Account Login
  GetPage(
    name: AppRoutes.createAccount,
    page: () => CreateAccountScreenUser(),
    transition: Transition.rightToLeft,
    binding: AppInitialBindings(),
  ),
  GetPage(
    name: AppRoutes.userRegistrationOtpVerificationScreen,
    page: () => UserRegistrationOtpVerificationScreen(),
    transition: Transition.rightToLeft,
    binding: AppInitialBindings(),
  ),
  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => UserForgotPasswordScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.userHomeScreen,
    page: () => UserHomeScreen(),
  ),
  GetPage(
      name: AppRoutes.userProductDetails,
      page: () => UserProductDetailsScreen(),
      transition: Transition.rightToLeft),
  GetPage(
    name: AppRoutes.otpScreen,
    page: () => UserOtpVerrfication(),
    transition: Transition.rightToLeft,
    //middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.resetPassword,
    page: () => UserResetPassword(),
    transition: Transition.rightToLeft,
    //middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.userBottomNav,
    page: () => UserBottomNav(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: AppRoutes.userNavigationScreen,
    page: () => UserNavigationScreen(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: AppRoutes.userSearchScreen,
    page: () => UserSearchScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.editProfile,
    page: () => UserEditProfile(),
  ),
  GetPage(
    name: AppRoutes.userProfile,
    page: () => UserProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.aboutUs,
    page: () => UserAboutUsScreen(),
  ),
  GetPage(
    name: AppRoutes.faqs,
    page: () => UserFaqsScreen(),
  ),
  GetPage(
    name: AppRoutes.privacyPolicy,
    page: () => UserPrivacyPolicyScreen(),
  ),
  GetPage(
    name: AppRoutes.termsAndConditions,
    page: () => UserTermsAndConditionScreen(),
  ),
  GetPage(
    name: AppRoutes.contactSupport,
    page: () => UserContactSupportScreen(),
  ),
  GetPage(
    name: AppRoutes.userCheckOut,
    page: () => UserCheckoutScreen(),
  ),
  GetPage(
    name: AppRoutes.userCreateOrderEditInformation,
    page: () => CreateOrderEditInformation(),
  ),
  GetPage(
    name: AppRoutes.userTrackOrder,
    page: () => UserTrackOrder(),
  ),
  GetPage(
    name: AppRoutes.userOrderProgress,
    page: () => UserOrderProgress(),
  ),
  GetPage(
    name: AppRoutes.viewOrder,
    page: () => UserViewOrder(),
  ),
  GetPage(
    name: AppRoutes.menuFavorites,
    page: () => UserManuFavourite(),
  ),
  GetPage(
    name: AppRoutes.menuOffers,
    page: () => UserMenuOffer(),
  ),
  GetPage(
    name: AppRoutes.menuCusSer,
    page: () => UserCustomerService(),
  ),
  GetPage(
    name: AppRoutes.menuPayment,
    page: () => UserMenuPayment(),
  ),
  GetPage(
    name: AppRoutes.menuRating,
    page: () => UserMenuRatings(),
  ),
  GetPage(
    name: AppRoutes.categories,
    page: () => CategoriesScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.newArrivals,
    page: () => NewarrivalsScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.popularItems,
    page: () => PopularitemScreen(),
    transition: Transition.rightToLeft,
  ),

  /////////////////////Owner Screening Routing//////////////////////////
  GetPage(name: AppRoutes.ownerOnboard, page: () => OwnerOnboardingScreen()),
  GetPage(
    name: AppRoutes.ownerCreateAccount,
    page: () => OwnerCreateAccount(),
    // transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerForgotPassword,
    page: () => OwnerForgotPassword(),
    // transition: Transition.leftToRightWithFade,
    // middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.ownerOtpVerificationScreen,
    page: () => OwnerOtpVerificationScreen(),
    // transition: Transition.leftToRightWithFade,
    //middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.ownerFotgotPasswordOtpScreen,
    page: () => OwnerForgotPasswordOtpScreen(),
    // transition: Transition.leftToRightWithFade,
    //middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.ownerResetPassword,
    page: () => OwnerResetPassword(),
    // transition: Transition.leftToRightWithFade,
    // middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.ownerStoreVerification,
    page: () => OwnerStoreVerification(),
    // middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.ownerBottomNav,
    page: () => OwnerBottomNav(),
  ),
  GetPage(
    name: AppRoutes.ownerAboutUs,
    page: () => OwnerAboutUs(),
  ),
  GetPage(
    name: AppRoutes.ownerFaq,
    page: () => OwnerFaqs(),
  ),
  GetPage(
    name: AppRoutes.ownerPrivacyPolicy,
    page: () => OwnerPrivacyPolicy(),
  ),
  GetPage(
    name: AppRoutes.ownerTermsAndConditions,
    page: () => OwnerTermsAndCondition(),
  ),
  GetPage(
    name: AppRoutes.ownerContactSupport,
    page: () => OwnerContactSupport(),
  ),
  GetPage(
    name: AppRoutes.forgotPasswordOtp,
    page: () => ForgotPasswordOtpScreen(),
  ),
  GetPage(
    name: AppRoutes.ownerEditProduct,
    page: () => OwnerEditProduct(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerAddNewProduct,
    page: () => OwnerAddNewProduct(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerOrderProgress,
    page: () => OwnerOrderProgress(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuBestSelling,
    page: () => OwnerMenuBestSellingItems(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuCancelOrder,
    page: () => OwnerMenuCancelledItems(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuTransaction,
    page: () => OwnerMenuTransection(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuOffers,
    page: () => OwnerMenuOffer(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuRating,
    page: () => OwnerMenuRatings(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.ownerMenuPaymentMethod,
    page: () => OwnerMenuPaymentOption(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.shopOwnerOtpVerificationScreen,
    page: () => ShopOwnerOtpVerificationScreen(),
    transition: Transition.rightToLeft,
  ),

  // Forgot Password

  //Otp Screen

  //Reset Password
];
