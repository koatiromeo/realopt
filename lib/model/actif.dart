import 'package:flutter/material.dart';
class Actif {
  late String type;
  late String name;
  late String description;
  late String currentValue;

  Actif(
      {
        required this.type,
        required this.name,
        required this.description,
        required this.currentValue,
      }
      );
}