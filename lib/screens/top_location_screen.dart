import 'package:flutter/material.dart';
import 'package:realopt/screens/shared_screen.dart';

class TopLocationScreen extends StatefulWidget {
  const TopLocationScreen({super.key});

  @override
  State<TopLocationScreen> createState() => _TopLocationScreenState();
}

class _TopLocationScreenState extends State<TopLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedScreen(
      isBackButton: false,
      child: Text("top_location"),
    );
  }
}
