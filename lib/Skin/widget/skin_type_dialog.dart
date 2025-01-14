import 'package:flutter/material.dart';

class SkinTypeDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String selectedTime) onSaved;
  final VoidCallback onSaveComplete;

  SkinTypeDialog({
    required this.initialValue,
    required this.onSaved,
    required this.onSaveComplete,
  });

  @override
  _SkinTypeDialogState createState() => _SkinTypeDialogState();
}

class _SkinTypeDialogState extends State<SkinTypeDialog> {
  String selectedTime = '';

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Skin Concerns'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Oily'),
            value: 'Oily',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Oily';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Dry'),
            value: 'Dry',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Dry';
              });
            },
          ),
                    RadioListTile<String>(
            title: const Text('Combination'),
            value: 'Combination',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Combination';
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onSaved(selectedTime);
            widget.onSaveComplete();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
        TextButton(
          onPressed: () {
            widget.onSaveComplete();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}