import 'package:flutter/material.dart';
import 'package:realopt/screens/shared_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SharedScreen(
      isBackButton: false,
      isBottomTab: true,
      child: Text("cool"),
    );
  }
}
