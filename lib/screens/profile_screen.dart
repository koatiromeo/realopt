import 'package:realopt/Constant/ColorGlobal.dart';
import 'package:realopt/pages/EditProfilePage.dart';
import 'package:realopt/pages/GuestHomePage.dart';
import 'package:realopt/pages/SettingsPage.dart';
import 'package:flutter/material.dart';
import '../../components/dashboard/profile_menu.dart';
import '../../components/dashboard/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen>  createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedItemIndex = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: ColorGlobal.whiteColor),),
        backgroundColor: ColorGlobal.colorPrimary,
        foregroundColor: ColorGlobal.whiteColor,
      ),
      bottomNavigationBar: Row(
        children: [
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.edit_document, 1),
          buildNavBarItem(Icons.camera, 2),
          buildNavBarItem(Icons.bar_chart, 3),
          buildNavBarItem(Icons.person, 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const ProfilePic(),
            const SizedBox(height: 30),
            ProfileMenu(
              text: "Edit My Profile",
              icon: "assets/icons/User.svg",
              press: ()  {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const EditProfilePage()));
              },
            ),
            ProfileMenu(
              text: "My Properties",
              icon: "assets/icons/home.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "My Documents",
              icon: "assets/icons/edit_document.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "My Stactics",
              icon: "assets/icons/bar_chart.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const SettingsPage()));
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log_out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
          if(index == 2){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => GuestHomePage()));
          }

        });

      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
            border:
            const Border(bottom: BorderSide(width: 4, color: Colors.green)),
            gradient: LinearGradient(colors: [
              Colors.green.withOpacity(0.3),
              Colors.green.withOpacity(0.016),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? const Color(0XFF00B868) : Colors.grey,
        ),
      ),
    );
  }

}

