import 'package:ecom_sel/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/home/home.dart';

class AppRoutes {
  static final pages = [
    // GetPage(name: ERoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: ERoutes.onboarding, page: () => const OnBoardingScreen()),
    // GetPage(name: ERoutes.coursesDashboard, page: () => const CoursesDashboard()),
    GetPage(name: ERoutes.eComDashboard, page: () => const HomeScreen()),

    // GetPage(name: ERoutes.phoneSignIn, page: () => const PhoneNumberScreen()),
    // GetPage(name: ERoutes.otpVerification, page: () => const PhoneOtpScreen()),
    // GetPage(name: ERoutes.reAuthenticateOtpVerification, page: () => const ReAuthenticatePhoneOtpScreen()),
    GetPage(name: ERoutes.profileScreen, page: () => const ProfileScreen()),
    GetPage(name: ERoutes.cartScreen, page: () => const CartScreen()),
    GetPage(name: ERoutes.checkoutScreen, page: () => const CheckoutScreen()),
    // GetPage(name: ERoutes.favouritesScreen, page: () => const FavouriteScreen()),

    // GetPage(
    //   name: ERoutes.notification,
    //   page: () => const NotificationScreen(),
    //   binding: NotificationBinding(),
    //   transition: Transition.fade,
    // ),
    // GetPage(
    //   name: ERoutes.notificationDetails,
    //   page: () => const NotificationDetailScreen(),
    //   binding: NotificationBinding(),
    //   transition: Transition.fade,
    // ),
  ];
}
