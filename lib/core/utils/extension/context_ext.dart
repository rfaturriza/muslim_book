import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:quranku/core/components/loading_dialog.dart';

import '../themes/color_schemes_material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get size => MediaQuery.of(this).size;

  double get height => size.height;

  double get width => size.width;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  double get topPadding => padding.top;

  double get bottomPadding => padding.bottom;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

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
      backgroundColor: theme.colorScheme.errorContainer,
      textStyle: textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onErrorContainer,
      ),
    );
  }

  showInfoToast(String message) {
    return showToast(
      message,
      context: this,
      textStyle: textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onTertiaryContainer,
      ),
      backgroundColor: theme.colorScheme.tertiaryContainer,
    );
  }

  showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> appSnackBar(
    String message, {
    SnackBarAction? action,
  }) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: theme.colorScheme.secondary,
        content: Text(message),
        action: action,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool get isDarkMode {
    return theme.brightness == Brightness.dark;
  }
}

extension ColorSchemeExt on ColorScheme {
  Color get surfaceContainer {
    return brightness == Brightness.dark
        ? MaterialTheme.darkScheme().surfaceContainer
        : MaterialTheme.lightScheme().surfaceContainer;
  }
}
