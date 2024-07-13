import 'package:flutter/material.dart';

class SelectableDropdown extends StatefulWidget {


  const SelectableDropdown({super.key});

  @override
  State<SelectableDropdown> createState() => _SelectableDropdownState();
}

class _SelectableDropdownState extends State<SelectableDropdown> {
  String? selectedValue;
  final List<String> options = [
    'Document Generation',
    'Real Estate Optimization',
    'Recommendation',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select an option',
        border: OutlineInputBorder(),
      ),
      value: selectedValue,
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

