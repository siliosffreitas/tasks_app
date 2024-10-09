import 'package:flutter/material.dart';

import '../components/index.dart';

mixin UiErrorManager {
  void handleMainError(BuildContext context, Stream<String?> stream) {
    stream.listen(
      (error) {
        if (error != null) {
          showMessage(context, error);
        }
      },
    );
  }
}
