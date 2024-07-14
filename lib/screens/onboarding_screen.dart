import 'package:flutter/material.dart';
import 'package:realopt/components/home/onboard_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            children: [
              OnboardView(
                  controller: controller,
                  title: "Maximize Your Investment",
                  subtitle:
                      "Our AI-based recommendation system helps you easily find the property that will maximize your profits on your real estate investments.",
                  path: "lib/assets/1.png",
                  isLastPage: isLastPage),
              OnboardView(
                  controller: controller,
                  title: "Streamline Financial Planning",
                  subtitle:
                      "Utilize our comprehensive financial simulation tools to plan and manage your investments with precision and confidence.",
                  path: "lib/assets/2.png",
                  isLastPage: isLastPage),
              OnboardView(
                  controller: controller,
                  title: "Simplify Property Management",
                  subtitle:
                      "Manage investor profiles, generate essential documents and explore property options effortlessly with our intuitive platform.",
                  path: "lib/assets/3.png",
                  isLastPage: isLastPage),
            ],
          ),
        ),
      ),
    );
  }
}
