import 'package:flutter/material.dart';
import 'package:quranku/core/components/loading_dialog.dart';
import 'package:quranku/core/components/permission_dialog.dart';

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

  static void showPermissionDialog(
    BuildContext context, {
    String? title,
    String? content,
    required VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) => PermissionDialog(
        onOk: onOk,
        title: title,
        content: content,
      ),
    );
  }
}
