import 'package:flutter/material.dart';

mixin SessionManager {
  void handleSessionExpired(BuildContext context, Stream<bool> stream) {
    stream.listen(
      (bool isExpired) {
        if (isExpired) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
        }
      },
    );
  }
}
