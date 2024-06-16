import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFormField extends StatefulWidget {
  late String title;
  late String hintText;
  late TextEditingController dataController;
  late String errorText;

  PhoneFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.dataController,
    required this.errorText

  });

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        IntlPhoneField(
          controller: widget.dataController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: widget.hintText,
            errorText: widget.errorText == "" ? null : widget.errorText
          ),
          initialCountryCode: 'CA', // Set initial country code to Canada
        ),
      ],
    );
  }
}
