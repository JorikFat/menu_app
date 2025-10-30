import 'package:flutter/material.dart';

extension ObjectExt<T> on T {
  T? takeIf(bool Function(T) block) => block(this) ? this : null;
}

extension WidgetExt on Widget {
  Widget badge(int? count) =>
      count != null ? Badge(label: Text(count.toString()), child: this) : this;
}