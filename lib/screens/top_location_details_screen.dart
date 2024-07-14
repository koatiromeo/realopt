import 'package:flutter/material.dart';
import 'package:realopt/screens/shared_screen.dart';

class TopLocationDetails extends StatefulWidget {
  const TopLocationDetails({super.key});

  @override
  State<TopLocationDetails> createState() => _TopLocationDetailsState();
}

class _TopLocationDetailsState extends State<TopLocationDetails> {
  @override
  Widget build(BuildContext context) {
    return SharedScreen(
      isBackButton: false,
      child: Text("top location details"),
    );
  }
}
