import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Badge badge(int count) => Badge(
        label: count > 0 ? Text(count.toString()) : null,
        child: this,
      );
}
