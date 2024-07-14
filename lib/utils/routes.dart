import 'package:flutter/material.dart';
import 'package:realopt/screens/account_empty_screen.dart';
import 'package:realopt/screens/account_location_screen.dart';
import 'package:realopt/screens/account_profile_screen.dart';
import 'package:realopt/screens/agent_profile_screen.dart';
import 'package:realopt/screens/complete_profile_screen.dart';
import 'package:realopt/screens/dashboard_screen.dart';
import 'package:realopt/screens/document_management_screen.dart';
import 'package:realopt/screens/email_verify_screen.dart';
import 'package:realopt/screens/faq_screen.dart';
import 'package:realopt/screens/favourite_screen.dart';
import 'package:realopt/screens/featured_screen.dart';
import 'package:realopt/screens/featured_details_screen.dart';
import 'package:realopt/screens/forgot_password_screen.dart';
import 'package:realopt/screens/gallery_grid_view.dart';
import 'package:realopt/screens/home_screen.dart';
import 'package:realopt/screens/about_us_screen.dart';
import 'package:realopt/screens/download_screen.dart';
import 'package:realopt/screens/features_screen.dart';
import 'package:realopt/screens/investors_profiles_management_screen.dart';
import 'package:realopt/screens/landing_screen.dart';
import 'package:realopt/screens/login_screen.dart';
import 'package:realopt/screens/onboarding_screen.dart';
import 'package:realopt/screens/promotion_screen.dart';
import 'package:realopt/screens/properties_exploration_guest_user_screen.dart';
import 'package:realopt/screens/properties_exploration_screen.dart';
import 'package:realopt/screens/search_screen.dart';
import 'package:realopt/screens/sign_up_screen.dart';
import 'package:realopt/screens/simulation_generation_guest_user_screen.dart';
import 'package:realopt/screens/simulation_generation_screen.dart';
import 'package:realopt/screens/simulations_management_screen.dart';
import 'package:realopt/screens/started_screen.dart';
import 'package:realopt/screens/top_agent_screen.dart';
import 'package:realopt/screens/top_location_details_screen.dart';
import 'package:realopt/screens/top_location_screen.dart';
import 'package:realopt/screens/user_account_scree.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/constants/colors.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name)
    {
      // Guest User Access Routes
      case RoutesName.landingScreen:
        return MaterialPageRoute(builder: (context) => LandingScreen());
      case RoutesName.featuresScreen:
        return MaterialPageRoute(builder: (context) => FeaturesScreen());
      case RoutesName.downloadScreen:
        return MaterialPageRoute(builder: (context) => DownloadScreen());
      case RoutesName.aboutUsScreen:
        return MaterialPageRoute(builder: (context) => AboutUsScreen());
      case RoutesName.emailVerifyScreen:
        return MaterialPageRoute(builder: (context) => const EmailVerifyScreen());
      case RoutesName.startedScreen:
        return MaterialPageRoute(builder: (context) => const StartedScreen());
      case RoutesName.onboardingScreen:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.signUpScreen:
        return MaterialPageRoute(builder: (context) => const SingUpScreen());
      case RoutesName.simulationsGenerationGuestUserScreen:
        return MaterialPageRoute(builder: (context) => const SimulationGenerationGuestUserScreen());
      case RoutesName.propertiesExplorationsGuestUserScreen:
        return MaterialPageRoute(builder: (context) => const PropertiesExplorationGuestUserScreen());
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());

      // Broker And Investor Users Access Routes
      case RoutesName.completeProfileScreen:
        return MaterialPageRoute(builder: (context) => const CompleteProfileScreen());
      case RoutesName.dashboardScreen:
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      case RoutesName.documentManagementScreen:
        return MaterialPageRoute(builder: (context) => const DocumentManagementScreen());
      case RoutesName.simulationsManagementScreen:
        return MaterialPageRoute(builder: (context) => const SimulationsManagementScreen());
      case RoutesName.simulationsGenerationScreen:
        return MaterialPageRoute(builder: (context) => const SimulationGenerationScreen());
      case RoutesName.propertiesExplorationScreen:
        return MaterialPageRoute(builder: (context) => const PropertiesExplorationScreen());


      // Broker User Only Access Routes
      case RoutesName.investorsProfilesManagementScreen:
        return MaterialPageRoute(builder: (context) => const InvestorsProfilesManagementScreen());


      case RoutesName.favoriteScreen:
        return MaterialPageRoute(builder: (context) => const FavouriteScreen());
      case RoutesName.faqScreen:
        return MaterialPageRoute(builder: (context) => const FaqScreen());
      case RoutesName.galleryGridView:
        return MaterialPageRoute(builder: (context) => const GalleryGridScreen());
      case RoutesName.accountEmptyScreen:
        return MaterialPageRoute(builder: (context) => const AccountEmptyScreen());
      case RoutesName.accountLocationScreen:
        return MaterialPageRoute(builder: (context) => const AccountLocationScreen());

      case RoutesName.userAccountScreen:
        return MaterialPageRoute(builder: (context) => const UserAccountScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (context) => const SearchScreen());
      case RoutesName.favoriteScreen:
        return MaterialPageRoute(builder: (context) => const FavouriteScreen());
      case RoutesName.promotionScreen:
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
