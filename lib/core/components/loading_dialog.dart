import 'package:flutter/material.dart';
import 'package:quranku/core/components/spacer.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;

  const LoadingDialog({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                context.theme.colorScheme.onSurface,
              ),
            ),
            const VSpacer(),
            Text(message ?? 'Loading...',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.theme.colorScheme.onSurface,
                )),
          ],
        ),
      ),
    );
  }
}
