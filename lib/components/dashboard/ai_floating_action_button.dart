import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realopt/dashboard/ai.dart';
import 'package:realopt/dashboard/style/colors.dart';

class AiFloatingActionButton extends StatefulWidget {
  const AiFloatingActionButton({super.key});

  @override
  State<AiFloatingActionButton> createState() => _AiFloatingActionButtonState();
}

class _AiFloatingActionButtonState extends State<AiFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
                child: AI()));
      },
      tooltip: 'AI',
      backgroundColor: AppColors.white,
      child: IconButton(
          icon:  Image.asset('lib/assets/images/ai.png') ,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400),
                    child: AI()));
          }),
    );
  }
}
