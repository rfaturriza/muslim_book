import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class ButtonDrawer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const ButtonDrawer({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      dense: true,
      tileColor: context.theme.colorScheme.primary,
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
    );
  }
}
