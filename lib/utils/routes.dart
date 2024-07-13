import 'package:flutter/material.dart';
import 'package:realopt/screens/account_empty_screen.dart';
import 'package:realopt/screens/account_location_screen.dart';
import 'package:realopt/screens/account_profile_screen.dart';
import 'package:realopt/screens/agent_profile_screen.dart';
import 'package:realopt/screens/dashboard_screen.dart';
import 'package:realopt/screens/faq_screen.dart';
import 'package:realopt/screens/favourite_screen.dart';
import 'package:realopt/screens/featured_screen.dart';
import 'package:realopt/screens/featured_details_screen.dart';
import 'package:realopt/screens/forgot_password_screen.dart';
import 'package:realopt/screens/gallery_grid_view.dart';
import 'package:realopt/screens/home_screen.dart';
import 'package:realopt/screens/about_us_page_screen.dart';
import 'package:realopt/screens/ladingPageScreen/download_page_screen.dart';
import 'package:realopt/screens/ladingPageScreen/features_page_screen.dart';
import 'package:realopt/screens/ladingPageScreen/landing_page_screen.dart';
import 'package:realopt/screens/login_screen.dart';
import 'package:realopt/screens/onboarding_screen.dart';
import 'package:realopt/screens/otp_screen.dart';
import 'package:realopt/screens/promotion_screen.dart';
import 'package:realopt/screens/search_screen.dart';
import 'package:realopt/screens/sign_up_screen.dart';
import 'package:realopt/screens/started_screen.dart';
import 'package:realopt/screens/top_agent_screen.dart';
import 'package:realopt/screens/top_location_details_screen.dart';
import 'package:realopt/screens/top_location_screen.dart';
import 'package:realopt/screens/user_account_scree.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/constant/colors.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name)
    {
      case RoutesName.landingPageScreen:
        return MaterialPageRoute(builder: (context) => LandingPageScreen());
      case RoutesName.featuresPageScreen:
        return MaterialPageRoute(builder: (context) => FeaturesPageScreen());
      case RoutesName.downloadPageScreen:
        return MaterialPageRoute(builder: (context) => DownloadPageScreen());
      case RoutesName.aboutUsPageScreen:
        return MaterialPageRoute(builder: (context) => AboutUsPageScreen());
      case RoutesName.onboarding_screen:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case RoutesName.startedScreen:
        return MaterialPageRoute(builder: (context) => const StartedScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case RoutesName.faqScreen:
        return MaterialPageRoute(builder: (context) => const FaqScreen());
      case RoutesName.galleryGridView:
        return MaterialPageRoute(builder: (context) => const GalleryGridScreen());
      case RoutesName.accountEmptyScreen:
        return MaterialPageRoute(builder: (context) => const AccountEmptyScreen());
      case RoutesName.accountLocationScreen:
        return MaterialPageRoute(builder: (context) => const AccountLocationScreen());
      case RoutesName.otpScreen:
        return MaterialPageRoute(builder: (context) => OtpScreen(data: settings.arguments as Map));
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());
      case RoutesName.userAccountScreen:
        return MaterialPageRoute(builder: (context) => const UserAccountScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.authScreen:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (context) => const SearchScreen());
      case RoutesName.favoriteScreen:
        return MaterialPageRoute(builder: (context) => const FavouriteScreen());
      case RoutesName.promotionScreem:
        return MaterialPageRoute(builder: (context) => const PromotionScreen());
      case RoutesName.featuredScreen:
        return MaterialPageRoute(builder: (context) => const FeaturedScreen());
      case RoutesName.featuredDetailsScreen:
        return MaterialPageRoute(builder: (context) => const FeaturedDetailsScreen());
      case RoutesName.topLocationScreen:
        return MaterialPageRoute(builder: (context) => const TopLocationScreen());
      case RoutesName.topLocationDetailsScreen:
        return MaterialPageRoute(builder: (context) => const TopLocationDetails());
      case RoutesName.topAgentScreen:
        return MaterialPageRoute(builder: (context) => const TopAgentScreen());
      case RoutesName.agentProfileScreen:
        return MaterialPageRoute(builder: (context) => const AgentProfileScreen());
      case RoutesName.profileScreen:
        return MaterialPageRoute(builder: (context) => const AccountProfileScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Invalid Route",
                style: TextStyle(color: AppColors.primaryColor, fontSize: 20),
              ),
            ),
          );
        });
    }
  }
}
