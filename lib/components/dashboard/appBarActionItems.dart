import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realopt/utils/responsive.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:realopt/localization/language.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      DropdownButton<Language>(
          underline: const SizedBox(),
          icon: SvgPicture.asset(
            'lib/assets/svgs/earth.svg',
            width: 20,
          ),
          onChanged: (Language? language) {
          // TODO: to call change language method
          },
          items: Language.languageList() .map<DropdownMenuItem<Language>>
          (
                    (e) => DropdownMenuItem<Language>
                            (
                                value: e,
                                child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                                Text(
                                                    e.flag,
                                                    style: const TextStyle(fontSize: 30),
                                                ),
                                                Text(e.name)
                                            ],
                                ),
                            ),
          ).toList(),
        ),
        const SizedBox(width: 10),
        Stack(
          children: [
            IconButton(
              icon: SvgPicture.asset('lib/assets/svgs/ring.svg', width: 20.0),
              onPressed: () {},
            ),
            Positioned(
              right: 9,
              top: 9,
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: const Text(
                  '5',  // Replace with dynamic notification count
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Row(children: [
          PopupMenuButton(
            child: const Row(
                children:
                [
                  CircleAvatar(
                      radius: 17,
                      backgroundImage: AssetImage("lib/assets/images/default-user.png"),
                      ),
                    Icon(Icons.arrow_drop_down_outlined, color: AppColors.black),
                ],
            ),
            onSelected: (value) {
              if (value == "profile") {
                // add desired output
              }else if(value == "settings"){
                // add desired output
              }else if(value == "logout"){
                // add desired output
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "profile",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.account_box),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "settings",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.settings)
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.logout)
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          )
        ])
      ],
    );
  }
}
