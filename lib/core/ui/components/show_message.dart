import 'package:flutter/material.dart';

void showMessage(
  BuildContext context,
  String message, {
  Function()? onClose,
  Widget? badge,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: const Text("Atenção"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
