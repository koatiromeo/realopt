import 'package:flutter/material.dart';
import 'package:realopt/screens/shared_screen.dart';

class AccountProfileScreen extends StatefulWidget {
  const AccountProfileScreen({super.key});

  @override
  State<AccountProfileScreen> createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedScreen(
      isBackButton: false,
      isBottomTab: true,
      child: Text("cool"),
    );
  }
}
