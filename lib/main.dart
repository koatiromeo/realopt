import 'package:flutter/material.dart';
import 'package:realopt/auth/LoginScreen.dart';
import 'package:realopt/dashboard/dashboard.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:realopt/document/document.dart';
import 'package:realopt/form/responsive_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REALOPT',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg
      ),
      home: Dashboard(),
      );
  }

}
