// Dialog StatefulWidget
import 'package:flutter/material.dart';

class SkinConcernsDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String selectedTime) onSaved;
  final VoidCallback onSaveComplete;

  SkinConcernsDialog({
    required this.initialValue,
    required this.onSaved,
    required this.onSaveComplete,
  });

  @override
  _SkinConcernsDialogState createState() => _SkinConcernsDialogState();
}

class _SkinConcernsDialogState extends State<SkinConcernsDialog> {
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
            title: const Text('Ance'),
            value: 'Ance',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Ance';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Wrinkles'),
            value: 'Wrinkles',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Wrinkles';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Dark Spot'),
            value: 'Dark Spot',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Dark Spot';
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