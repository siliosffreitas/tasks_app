import 'package:flutter/material.dart';

import '../components/index.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool> stream) {
    stream.listen(
      (bool isLoading) {
        if (isLoading) {
          showLoading(context);
        } else {
          hideLoading(context);
        }
      },
    );
  }
}
