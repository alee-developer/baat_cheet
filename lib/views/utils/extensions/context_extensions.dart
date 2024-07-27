import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  double get fullHeight => MediaQuery.sizeOf(this).height;

  double get fullWidth => MediaQuery.sizeOf(this).width;

  get onBackPressed => Navigator.pop(this);

  gotoNext({required Widget page}) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));
}
