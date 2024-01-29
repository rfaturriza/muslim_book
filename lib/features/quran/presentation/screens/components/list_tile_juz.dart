import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import 'number_pin.dart';

class ListTileJuz extends StatelessWidget {
  final Function() onTapJuz;
  final String number;
  final String name;
  final String description;
  final Color? backgroundColor;

  const ListTileJuz({
    super.key,
    required this.onTapJuz,
    required this.number,
    required this.name,
    required this.description,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListTile(
        onTap: onTapJuz,
        leading: NumberPin(number: number),
        title: Text(
          name,
          style: context.textTheme.titleMedium,
        ),
        subtitle: Text(
          description,
          style: context.textTheme.titleSmall,
        ),
      ),
    );
  }
}
