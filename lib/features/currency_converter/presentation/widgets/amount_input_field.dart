import 'package:flutter/material.dart';

class AmountInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const AmountInputField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Amount",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
