// Dialog StatefulWidget
import 'package:flutter/material.dart';

class RoutineTimeDialog extends StatefulWidget {
  final String initialValue;
  final void Function(String selectedTime) onSaved;
  final VoidCallback onSaveComplete;

  RoutineTimeDialog({
    required this.initialValue,
    required this.onSaved,
    required this.onSaveComplete,
  });

  @override
  _RoutineTimeDialogState createState() => _RoutineTimeDialogState();
}

class _RoutineTimeDialogState extends State<RoutineTimeDialog> {
  String selectedTime = '';

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Routine Time'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Morning'),
            value: 'Morning',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Morning';
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Night'),
            value: 'Night',
            groupValue: selectedTime,
            onChanged: (String? value) {
              setState(() {
                selectedTime = value ?? 'Night';
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