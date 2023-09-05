import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quranku/core/utils/themes/color.dart';

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

  void navigateTo(Widget widget, {Bloc? bloc}) {
    if (bloc != null) {
      _navigateToWithBloc(widget, bloc);
      return;
    }
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void _navigateToWithBloc(Widget widget, Bloc bloc) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => bloc,
          child: widget,
        ),
      ),
    );
  }

  void navigateBack() {
    Navigator.pop(this);
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

  showErrorToast(String message) {
    return showToast(
      message,
      context: this,
      backgroundColor: theme.colorScheme.error,
      textStyle: textTheme.bodySmall,
    );
  }

  showInfoToast(String message) {
    return showToast(
      message,
      context: this,
      textStyle: textTheme.bodySmall,
      backgroundColor: secondaryColor.shade800,
    );
  }
}
