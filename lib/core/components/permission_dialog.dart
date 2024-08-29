import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/generated/locale_keys.g.dart';

class PermissionDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final VoidCallback onOk;

  const PermissionDialog({
    super.key,
    this.title,
    this.content,
    required this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.theme.colorScheme.surface,
      title: Text(title ?? LocaleKeys.permissionTitle.tr()),
      content: Text(
        content ?? LocaleKeys.defaultPermissionMessage.tr(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(LocaleKeys.cancel.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            onOk();
            Navigator.pop(context);
          },
          child: Text(LocaleKeys.next.tr()),
        ),
      ],
    );
  }
}
