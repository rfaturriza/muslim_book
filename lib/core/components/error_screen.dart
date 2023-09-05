import 'package:flutter/material.dart';
import 'package:quranku/core/components/spacer.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final void Function()? onRefresh;

  const ErrorScreen({
    super.key,
    required this.message,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          // icon Refresh
          if (onRefresh != null) ...[
            const VSpacer(),
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh),
            ),
          ]
        ],
      ),
    );
  }
}
