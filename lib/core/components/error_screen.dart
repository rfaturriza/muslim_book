import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';
import 'package:quranku/generated/locale_keys.g.dart';

class ErrorScreen extends StatelessWidget {
  final String? message;
  final void Function()? onRefresh;

  const ErrorScreen({
    super.key,
    required this.message,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRefresh,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message ?? LocaleKeys.defaultErrorMessage.tr(),
                textAlign: TextAlign.center,
              ),
              // icon Refresh
              if (onRefresh != null) ...[
                IconButton(
                  onPressed: onRefresh,
                  icon: const Icon(Icons.refresh),
                  color: context.theme.colorScheme.onSurface,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
