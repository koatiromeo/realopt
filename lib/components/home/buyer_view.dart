import 'package:flutter/material.dart';
import 'package:realopt/components/home/accordion.dart';

class BuyerView extends StatelessWidget {
  const BuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        child: const AccordionApp(),
      ),
    );
  }
}
