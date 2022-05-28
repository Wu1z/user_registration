
import 'package:flutter/material.dart';
import 'package:user_registration/shared/widgets/default_button.dart';

class ErrorDialog extends StatelessWidget {

  final String message;

  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Error",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 20
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: DefaultButton(
                          text: "CONFIRM",
                          color: Colors.white,
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}