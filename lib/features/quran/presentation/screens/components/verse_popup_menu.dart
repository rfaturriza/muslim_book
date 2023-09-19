import 'package:flutter/material.dart';
import 'package:quranku/core/utils/extension/context_ext.dart';

import '../../../../../core/components/popup_menu.dart';
import '../../../../../core/utils/themes/color.dart';

class VersePopupMenuButton extends StatelessWidget {
  const VersePopupMenuButton({
    super.key,
    this.isBookmarked = false,
    this.onBookmarkPressed,
    this.onPlayPressed,
    this.onSharePressed,
  });

  final bool? isBookmarked;
  final VoidCallback? onBookmarkPressed;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onSharePressed;

  @override
  Widget build(BuildContext context) {
    return PopupMenuHorizontal(
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
            color: secondaryColor.shade900,
          ),
        ),
        IconButton(
          onPressed: () {
            onPlayPressed?.call();
            context.navigateBack();
          },
          icon: Icon(
            Icons.play_circle_outline,
            color: secondaryColor.shade900,
          ),
        ),
        IconButton(
          onPressed: () {
            onSharePressed?.call();
          },
          icon: Icon(
            Icons.ios_share,
            color: secondaryColor.shade900,
          ),
        ),
      ],
    );
  }
}
