import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;

  dismissKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void navigateTo(Widget widget) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void navigateToAndRemoveUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
  }

  void navigateToAndReplace(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }


}