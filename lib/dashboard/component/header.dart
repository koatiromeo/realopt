import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realopt/dashboard/config/responsive.dart';
import 'package:realopt/dashboard/investor_profile_form.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:realopt/dashboard/style/style.dart';

class Header extends StatelessWidget {
  String mainTitle;
  String subTitle;
  Header({
    super.key,
    required this.mainTitle,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: mainTitle,
                      size: 30,
                      fontWeight: FontWeight.w800),
                  PrimaryText(
                    text: subTitle,
                    size: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                  )
                ]),
          ),
        ]);
  }
}
