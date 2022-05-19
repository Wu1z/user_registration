import 'package:flutter/material.dart';

class AsyncButton extends StatelessWidget {
  final Function()? onPressed;
  final bool? isLoading;
  final String text;

  const AsyncButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        color: Theme.of(context).colorScheme.primary,
        height: 60,
        onPressed: (isLoading != null) && isLoading == false 
          ? onPressed 
          : null,
        child: isLoading ?? false
        ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.secondary, //<-- SEE HERE
          ),
        )
        : Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, 
          ),
        )
      ),
    );   
  }
}