import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../utils/themes/color.dart';

class ButtonDrawer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool withDecoration;

  const ButtonDrawer({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.withDecoration = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: withDecoration
          ? ShapeDecoration(
              gradient: LinearGradient(
                //from right top corner to left bottom corner
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  primaryColor.shade500,
                  primaryColor.shade500.withOpacity(0)
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            )
          : ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
      child: ListTile(
        style: ListTileStyle.drawer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        dense: true,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: context.textTheme.bodyMedium,
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: context.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
