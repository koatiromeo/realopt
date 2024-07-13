import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  late String title;
  late TextInputType? dataType;
  late String errorText;
  late TextEditingController dataController;

  CustomTextFormField({
    super.key,
    required this.title,
    required this.dataType,
    required this.errorText,
    required this.dataController
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 8),
          TextField(
            controller: widget.dataController,
            keyboardType: widget.dataType,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: widget.errorText == "" ? null : widget.errorText
            ),
          ),
        ]
    );
  }
}
