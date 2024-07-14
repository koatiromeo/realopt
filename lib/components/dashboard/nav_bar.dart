import 'package:realopt/constants/colors.dart';
import 'package:realopt/screens/notification_screen.dart';
import 'package:realopt/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Guest User'),
            accountEmail: Text('Sing Up for more.'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/Images/defaultuser.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: AppColors.colorPrimary),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Properties'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.edit_document),
            title: Text('Documents Automation'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text('Investors Profiles'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Statistics'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Recommadations'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => const SettingsScreen()));
              },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap:() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NotificationScreen()));
              },
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}