import 'package:flutter/material.dart';

class VSpacer extends StatelessWidget {
  final double? height;
  const VSpacer({super.key, this.height = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class HSpacer extends StatelessWidget {
  final double? width;
  const HSpacer({super.key, this.width = 16});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}

