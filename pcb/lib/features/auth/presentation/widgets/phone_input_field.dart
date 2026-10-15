import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const PhoneInputField({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        prefixText: '+92 ',
        border: OutlineInputBorder(),
      ),
    );
  }
}
