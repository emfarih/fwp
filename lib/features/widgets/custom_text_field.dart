import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.onChanged,
    required TextEditingController controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }
}
