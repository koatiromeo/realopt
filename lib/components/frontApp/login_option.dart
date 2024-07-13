import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  final String path;

  const LoginOption({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 200, // Limite la largeur maximale
          maxHeight: 200, // Limite la hauteur maximale
        ),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(path),
        ),
      ),
    );
  }
}
