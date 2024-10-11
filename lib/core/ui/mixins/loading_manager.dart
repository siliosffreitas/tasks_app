import 'package:flutter/material.dart';

import '../components/spinner_dialog.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen(
      (bool isLoading) {
        if (isLoading) {
          SpinnerDialog.showLoading(context);
        } else {
          SpinnerDialog.hideLoading(context);
        }
      },
    );
  }
}
