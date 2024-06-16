import 'package:flutter/material.dart';
import 'package:realopt/dashboard/config/responsive.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:realopt/dashboard/style/style.dart';

class HeaderAdminOptions extends StatelessWidget {
  String mainTitle;
  String subTitle;
  HeaderAdminOptions({
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {

                    },
                    icon:const Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.black
                    )
                ),
                IconButton(
                    onPressed: () {

                    },
                    icon:const Icon(
                        Icons.compare_arrows,
                        size: 30,
                        color: AppColors.black
                    )
                )
              ],
            ),
          )
        ]);
  }
}
