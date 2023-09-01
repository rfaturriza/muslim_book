import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          'assets/lottie/loading.json',
          width: context.width,
        ),
      ),
    );
  }
}
