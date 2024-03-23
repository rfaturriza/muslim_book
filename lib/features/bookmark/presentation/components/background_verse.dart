import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class BackgroundVerse extends StatelessWidget {
  const BackgroundVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      right: 0,
      left: 0,
      child: Text(
        'Maka sesungguhnya beserta kesulitan ada kemudahan,\n'
        'sesungguhnya beserta kesulitan itu ada kemudahan.\n'
        'QS 94 : 1',
        textAlign: TextAlign.center,
        style: context.theme.textTheme.bodySmall,
      ),
    );
  }
}
