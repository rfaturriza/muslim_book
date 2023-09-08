import 'package:flutter/material.dart';

import '../utils/themes/color.dart';

class PopupMenuHorizontal extends StatelessWidget {
  final List<Widget> children;
  const PopupMenuHorizontal({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: secondaryColor.shade700,
          width: 3,
        ),
      ),
      offset: const Offset(42, -10),
      color: secondaryColor.shade500,
      icon: const Icon(
        Icons.more_horiz,
        color: secondaryColor,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuWidget(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          )
        ];
      },
    );
  }
}


class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({Key? key, required this.height, required this.child})
      : super(key: key);

  final Widget child;

  @override
  final double height;

  bool get enabled => false;

  @override
  createState() => _PopupMenuWidgetState();

  @override
  bool represents(T? value) {
    return false;
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}

