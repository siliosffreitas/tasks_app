import 'package:flutter/material.dart';

void showConfirmationMessage(
  BuildContext context,
  String message,
  Function onConfirm,
) {
  showDialog(
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Confirmação'),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text('Não'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Sim'),
          onPressed: () {
            onConfirm.call();
            Navigator.pop(context);
          },
        ),
      ],
    ),
    context: context,
  );
}
