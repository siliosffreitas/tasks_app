import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Function() onTryAgain;
  final String error;

  const ErrorPage({Key? key, required this.onTryAgain, required this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: onTryAgain,
            child: const Text('Recarregar'),
          ),
        ],
      ),
    );
  }
}
