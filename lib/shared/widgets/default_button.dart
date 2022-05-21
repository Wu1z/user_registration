import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;

  const DefaultButton({
    Key? key, 
    required this.text, 
    required this.onPressed,
    this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Theme.of(context).colorScheme.primary;
    final buttonTextColor = textColor ?? Colors.white;
    return MaterialButton(
      padding: const EdgeInsets.all(15),
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey[200],
      color: buttonColor,
      disabledTextColor: Theme.of(context).colorScheme.onBackground,
      textColor: buttonTextColor,
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}