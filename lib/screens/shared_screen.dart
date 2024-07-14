import 'package:flutter/material.dart';
import 'package:realopt/components/home/app_button.dart';
import 'package:realopt/components/home/app_padding.dart';
import 'package:realopt/constants/colors.dart';
import 'package:realopt/utils/route_name.dart';

class SharedScreen extends StatelessWidget {
  final Widget child;
  final bool isBackButton, isActions, isBottomTab;
  const SharedScreen(
      {super.key,
        this.isActions = false,
        this.isBottomTab = false,
        required this.child,
        required this.isBackButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isBackButton
          ? AppBar(
        elevation: 0,
        actions: isActions
            ? [
          AppButton(
            onPress: () {
              Navigator.pushNamed(
                  context, RoutesName.userAccountScreen);
            },
            title: "Next",
            width: 100,
            isMarginLeft: true,
            bgColor: AppColors.primaryColor,
            textColor: AppColors.whiteColor,
          )
        ]
            : null,
      )
          : null,
      body: SafeArea(
        child: AppPadding(
            padddingValue: 15,
            child: SingleChildScrollView(
              child: child,
            )),
      ),
    );
  }
}
