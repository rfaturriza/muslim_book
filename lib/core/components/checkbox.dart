import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../utils/themes/color.dart';

class CheckBoxListTileMuslimBook extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckBoxListTileMuslimBook({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: defaultColor.shade50,
          activeColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: BorderSide(
            color: defaultColor.shade50,
            width: 2,
          ),
        ),
        Text(title),
      ],
    );
  }
}