import 'package:flutter/material.dart';

Future<void> showMessage(
  BuildContext context,
  String message, {
  Function()? onClose,
  Widget? badge,
}) async {
  await Future.delayed(Duration.zero);
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: const Text('Atenção'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: onClose ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ],
      );
    },
  );
}
