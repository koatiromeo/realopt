import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/screens/dashboard_screen.dart';
import 'package:realopt/screens/document_management_screen.dart';
import 'package:realopt/screens/investors_profiles_management_screen.dart';
import 'package:realopt/screens/properties_exploration_screen.dart';
import 'package:realopt/screens/recommendations_exploration_screen.dart';
import 'package:realopt/screens/simulations_management_screen.dart';
import 'package:realopt/constants/colors.dart';
import 'package:page_transition/page_transition.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Dashboard',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/dashboard.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: DashboardScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Investors Profiles',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/user.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: InvestorsProfilesManagementScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Documents Automation',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/clipboard.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: DocumentManagementScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Properties',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/bank.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: const PropertiesExplorationScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Simulations',
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/simulation.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: SimulationsManagementScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  tooltip: 'Recommendations',
                  padding:  const EdgeInsets.symmetric(vertical: 20.0),
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/recommendation.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: RecommendationsExplorationScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  tooltip: 'Settings',
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/settings.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 400),
                            child: RecommendationsExplorationScreen()));
                  }),
              IconButton(
                  iconSize: 20,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  tooltip: 'Logout',
                  icon: SvgPicture.asset(
                      'lib/assets/svgs/logout.svg',
                      width: 35,
                      colorFilter: const ColorFilter.mode(
                        AppColors.iconGray,
                        BlendMode.srcIn,
                      )
                  ),
                  onPressed: () {}),

            ],
          ),
        ),
      ),
    );
  }
}