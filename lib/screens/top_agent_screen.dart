import 'package:flutter/material.dart';
import 'package:realopt/components/shared/screen.dart';

class TopAgentScreen extends StatefulWidget {
  const TopAgentScreen({super.key});

  @override
  State<TopAgentScreen> createState() => _TopAgentScreenState();
}

class _TopAgentScreenState extends State<TopAgentScreen> {
  @override
  Widget build(BuildContext context) {
    return Screen(
      isBackButton: false,
      child: Text("top agent screen"),
    );
  }
}
