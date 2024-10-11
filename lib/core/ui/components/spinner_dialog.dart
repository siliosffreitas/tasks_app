import 'package:flutter/material.dart';

class SpinnerDialog {
  SpinnerDialog._();

  static bool _isLoadingVisible = false;

  static Future<void> showLoading(BuildContext context) async {
    _isLoadingVisible = true;
    await Future.delayed(Duration.zero);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        backgroundColor: const Color(0xFFF4F4F4),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Aguarde ...',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context) == true && _isLoadingVisible) {
      _isLoadingVisible = false;
      Navigator.pop(context);
    }
  }
}
