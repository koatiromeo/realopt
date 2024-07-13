import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/dashboard/investor_profile_form.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:realopt/constant/style.dart';
import 'package:realopt/form/selectable_dropdown.dart';

class HeaderAdminDropdown extends StatelessWidget {
  String mainTitle;
  String subTitle;
  HeaderAdminDropdown({
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
          Expanded(
            flex: Responsive.isDesktop(context) ? 2 : 3,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectableDropdown(),
              ],
            ),
          )
        ]);
  }
}
