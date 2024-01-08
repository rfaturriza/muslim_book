import 'package:flutter/material.dart';

import '../utils/themes/color.dart';

class DividerMuslimBook extends StatelessWidget {
  const DividerMuslimBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: defaultColor.shade200,
      height: 0,
    );
  }
}
