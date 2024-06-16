import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realopt/dashboard/config/size_config.dart';
import 'package:realopt/dashboard/dashboard.dart';
import 'package:realopt/dashboard/documents.dart';
import 'package:realopt/dashboard/investorsProfiles.dart';
import 'package:realopt/dashboard/properties.dart';
import 'package:realopt/dashboard/recommendations.dart';
import 'package:realopt/dashboard/simulations.dart';
import 'package:realopt/dashboard/style/colors.dart';
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
                            child: Dashboard()));
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
                            child: InvestorsProfiles()));
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
                            child: Documents()));
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
                            child: const Properties()));
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
                            child: Simulations()));
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
                            child: Recommendations()));
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
                            child: Recommendations()));
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