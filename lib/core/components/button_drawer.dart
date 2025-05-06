import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

class ButtonDrawer extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool withDecoration;
  final bool showBadge;
  final String? badgeText;
  final Color? badgeColor;

  const ButtonDrawer({
    super.key,
    required this.icon,
    this.iconColor,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.withDecoration = true,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
  });

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
                  context.theme.colorScheme.primary.withValues(alpha: 0.5),
                  context.theme.colorScheme.primary.withValues(alpha: 0),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            )
          : const ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
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
          color: iconColor,
        ),
        title: Badge(
          label: Text(
            badgeText ?? '',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
          isLabelVisible: showBadge,
          backgroundColor: context.theme.colorScheme.primary,
          child: Text(
            title,
            style: context.textTheme.bodyMedium,
          ),
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
