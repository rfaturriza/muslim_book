import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../../../../../core/components/popup_menu.dart';

class VersePopupMenuButton extends StatelessWidget {
  const VersePopupMenuButton({
    super.key,
    this.isBookmarked = false,
    this.onBookmarkPressed,
    this.onPlayPressed,
    this.onSharePressed,
    this.padding = const EdgeInsets.all(0),
  });

  final bool? isBookmarked;
  final VoidCallback? onBookmarkPressed;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onSharePressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: PopupMenuHorizontal(
        children: [
          IconButton(
            onPressed: () {
              onBookmarkPressed?.call();
              context.navigateBack();
            },
            icon: Icon(
              (isBookmarked ?? false)
                  ? Icons.bookmark_remove
                  : Icons.bookmark_add_outlined,
              color: context.theme.colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              onPlayPressed?.call();
              context.navigateBack();
            },
            icon: Icon(
              Icons.play_circle_outline,
              color: context.theme.colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              onSharePressed?.call();
            },
            icon: Icon(
              Icons.ios_share,
              color: context.theme.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
