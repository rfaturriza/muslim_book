import 'package:flutter/material.dart';
import 'package:quranku/core/components/loading_dialog.dart';

class AppDialog {
  static void showLoading(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }
}
