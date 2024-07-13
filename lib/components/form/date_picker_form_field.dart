import 'package:flutter/material.dart';

class DatePickerFormField extends StatefulWidget {
  late String title;
  late String hintSelectText;
  late String errorText;
  late TextEditingController dataController;


  DatePickerFormField({
    super.key,
    required this.title,
    required this.hintSelectText,
    required this.errorText,
    required this.dataController
  });

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}
class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime? _selectedDate;

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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: widget.hintSelectText,
                  border: const OutlineInputBorder(),
                  errorText: widget.errorText == "" ? null : widget.errorText
                ),
                controller: widget.dataController,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                _showDatePicker(context);
              },
              icon: const Icon(Icons.calendar_today),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.dataController.text = _selectedDate != null ? "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}" : '';
      });
    }
  }
}
