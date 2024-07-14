import 'package:flutter/material.dart';
import 'package:realopt/screens/shared_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedScreen(
      isBackButton: false,
      isBottomTab: true,
      child: Text("cool"),
    );
  }
}
