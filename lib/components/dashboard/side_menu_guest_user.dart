import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realopt/utils/size_config.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/constants/colors.dart';

class SideMenuGuestUser extends StatelessWidget {
  const SideMenuGuestUser({
    super.key,
  });

  void _showSignUpModal(BuildContext context, String description) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign-Up Required'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'To access this option, you need to sign up.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSignUp(context);
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSignUp(BuildContext context)
  {
    Navigator.pushNamed(
        context, RoutesName.signUpScreen);
  }


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
                    Navigator.of(context).pop();
                    _showSignUpModal(context, "The Dashboard provides a comprehensive overview of all the key metrics and activities within the RealOpt platform. Users can quickly access summaries of their investment performance, recent activities, and important notifications. The Dashboard is designed to offer a seamless and user-friendly experience, allowing users to stay informed and make data-driven decisions efficiently.");
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
                    Navigator.of(context).pop();
                    _showSignUpModal(context, "The Investors Profiles module allows users to manage detailed profiles of investors. This includes personal information, investment preferences, portfolio performance, and contact details. The module enables users to track and analyze the behavior and interests of investors, facilitating personalized communication and better relationship management.");
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
                    Navigator.of(context).pop();
                    _showSignUpModal(context, "The Documents Automation module streamlines the process of creating, managing, and storing documents related to real estate investments. It automates the generation of standard documents such as contracts, reports, and agreements, ensuring consistency and accuracy. This module reduces the administrative burden on users, allowing them to focus on more strategic tasks.");
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
                    Navigator.pushNamed(
                        context, RoutesName.propertiesExplorationScreen);
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
                    Navigator.pushNamed(
                        context, RoutesName.simulationsGenerationGuestUserScreen);
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
                    Navigator.of(context).pop();
                    _showSignUpModal(context, "The Recommendations module leverages advanced AI algorithms to provide personalized investment recommendations. Based on the user's profile, investment history, and market trends, the system suggests properties and strategies that align with the user's goals. This module enhances the decision-making process by offering data-driven insights and expert guidance.");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}