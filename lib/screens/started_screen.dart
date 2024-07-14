import 'package:flutter/material.dart';
import 'package:realopt/components/home/app_button.dart';
import 'package:realopt/components/home/gap.dart';
import 'package:realopt/components/home/or_divider.dart';
import 'package:realopt/components/home/login_option.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/utils/route_name.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/constants/styles.dart';
import 'package:realopt/utils/responsive_widget.dart';

class StartedScreen extends StatefulWidget {
  const StartedScreen({super.key});

  @override
  State<StartedScreen> createState() => _StartedScreenState();
}

class _StartedScreenState extends State<StartedScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backColor,
      body: SizedBox(
        height: height,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !Responsive.isDesktop(context) ? const SizedBox() : Expanded(
              child: Container(
                height: height,
                color: AppColors.blueDarkColor,
                child: Center(
                  child: Text(
                    'Real Estate Optimize',
                    style: ralewayStyle.copyWith(
                      fontSize: 48.0,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: height,
                margin: EdgeInsets.symmetric(horizontal: ResponsiveWidget.isSmallScreen(context)? height * 0.032 : height * 0.12),
                color: AppColors.backColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.07),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centrer les options
                        children: [
                          LoginOption(path: "lib/assets/images/login1.png"),
                          Gap(isWidth: true, isHeight: false, width: 10),
                          LoginOption(path: "lib/assets/images/login2.png"),
                        ],
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.01),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Centrer les options
                        children: [
                          LoginOption(path: "lib/assets/images/login3.png"),
                          Gap(isWidth: true, isHeight: false, width: 10),
                          LoginOption(path: "lib/assets/images/login4.png"),
                        ],
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.035),
                      Row(
                        children: [
                          Text(
                            "Ready to ",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            "explore?",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: AppColors.blueDarkColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.035),
                      AppButton(
                        onPress: () {
                          Navigator.pushNamed(context, RoutesName.propertiesExplorationsGuestUserScreen);
                        },
                        title: "Continue as Guest",
                        textColor: AppColors.whiteColor,
                        bgColor: AppColors.blueDarkColor,
                        icon: const Icon(
                          Icons.person_add,
                          color: AppColors.whiteColor,
                          size: 25,
                        ),
                        isButtonIcon: true,
                        height: height * 0.08,
                        radius: 15,
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.019),
                      const OrDivider(),
                      Gap(isWidth: false, isHeight: true, height: height * 0.015),
                      AppButton(
                        onPress: () {
                          Navigator.pushNamed(context, RoutesName.loginScreen);
                        },
                        title: "Login to Your Account",
                        textColor: AppColors.whiteColor,
                        bgColor: AppColors.blueDarkColor,
                        icon: const Icon(
                          Icons.lock_open,
                          color: AppColors.whiteColor,
                          size: 25,
                        ),
                        isButtonIcon: true,
                        height: height * 0.08,
                        radius: 15,
                      ),
                      Gap(isWidth: false, isHeight: true, height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.signUpScreen);
                            },
                            child: Text(
                              " Register",
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.blueDarkColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
