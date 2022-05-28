import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final TextInputType? inputType;
  final String? errorText;
  final Widget? icon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const DefaultTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
    this.maxLength,
    this.inputType,
    this.errorText,
    this.icon,
    this.suffixIcon,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      obscureText: isPassword,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      decoration: InputDecoration(
        label: Text(label),
        errorText: errorText,
        filled: true,
        counterText: "",
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none
          ),
        ),
      ),
    );
  }
}