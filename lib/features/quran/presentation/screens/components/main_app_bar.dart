import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/themes/color.dart';

class MainAppBar extends StatelessWidget  implements PreferredSizeWidget  {
  const MainAppBar({
    super.key,
    required this.onPressedMenu,
    required this.onPressedQibla,
  });

  final void Function() onPressedMenu;
  final void Function() onPressedQibla;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onPressedMenu,
        icon: Icon(
          FontAwesomeIcons.bars,
          color: defaultColor.shade50,
          size: 20,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onPressedQibla,
          icon: Icon(
            Icons.explore_outlined,
            color: defaultColor.shade50,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}