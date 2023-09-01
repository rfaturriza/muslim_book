import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/themes/color.dart';

class MainAppBar extends StatelessWidget  implements PreferredSizeWidget  {
  const MainAppBar({
    super.key,
    required this.onPressedMenu,
    required this.onPressedSetting,
  });

  final void Function() onPressedMenu;
  final void Function() onPressedSetting;

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
          onPressed: onPressedSetting,
          icon: Icon(
            FontAwesomeIcons.gear,
            color: defaultColor.shade50,
            size: 20,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}