import 'package:flutter/material.dart';
import 'package:realopt/components/frontApp/account_form.dart';
import 'package:realopt/components/gap.dart';
import 'package:realopt/components/header_title.dart';
import 'package:realopt/components/shared/screen.dart';
import 'package:realopt/constant/colors.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Screen(
      isBackButton: true,
      isBottomTab: false,
      child: Column(
        children: [
          const HeaderTitle(
            title: "Fill your",
            title1: "information below",
            bottomTitle: "You can edit this later on your account setting.",
            subtitle: "",
            isUnderTitle: true,
          ),
          Gap(
            isWidth: false,
            isHeight: true,
            height: height * 0.03,
          ),
          const AccountForm()
        ],
      ),
    );
  }
}
