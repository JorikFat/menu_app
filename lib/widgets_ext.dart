import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget badge(int count) =>
      count > 0 ? Badge(label: Text(count.toString()), child: this) : this;
}
