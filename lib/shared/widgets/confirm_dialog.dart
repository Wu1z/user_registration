import 'package:flutter/material.dart';
import 'package:user_registration/shared/widgets/default_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String titulo;
  final String descricao;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    Key? key,
    required this.titulo, 
    required this.descricao,
    required this.onConfirm,
  }) : super(key: key);

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
                  titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  descricao,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DefaultButton(
                        text: "NO",
                        color: Colors.transparent,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: DefaultButton(
                        text: "YES",
                        color: Colors.grey[800],
                        textColor: Colors.white,
                        onPressed: onConfirm,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}