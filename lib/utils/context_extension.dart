import 'package:flutter/material.dart';

/// https://medium.com/@azharbinanwar/coding-made-easy-using-handy-extensions-on-buildcontext-46283b3655be
extension BuildContextEntension<T> on BuildContext {
  /// Sizes
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;
  bool get smallerThanTablet => MediaQuery.of(this).size.width < 650.0;
  bool get smallerThanDesktop => MediaQuery.of(this).size.width < 1024.0;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall => MediaQuery.of(this).size.width < 850.0 && MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  Size get size => MediaQuery.of(this).size;
  double get safeAreaHeight => MediaQuery.sizeOf(this).height
      - MediaQuery.paddingOf(this).vertical
      - MediaQuery.viewInsetsOf(this).vertical
      - MediaQuery.viewPaddingOf(this).vertical;

  /// colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get cardColor => Theme.of(this).cardColor;
  Color get errorColor => Theme.of(this).colorScheme.error;

  /// bottomSheet
  Future<T?> showBottomSheet(
    Widget child, {
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
  }) {
    return showModalBottomSheet(
      context: this,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      builder: (context) => Wrap(children: [child]),
    );
  }
}