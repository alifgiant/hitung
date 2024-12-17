import 'package:flutter/material.dart';

import 'context_ext.dart';

extension WidgetExt on Widget {
  Widget dynamicFixedWidth(BuildContext ctx, {double width = 550}) {
    final screenWidth = ctx.width;
    if (screenWidth < width) return this;
    return fixedWidth(width: width);
  }

  Widget fixedWidth({double width = 550}) {
    return SizedBox(width: width, child: this);
  }

  Widget left() => Align(alignment: Alignment.bottomLeft, child: this);

  Widget center() => Center(child: this);

  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget watch({required Listenable animation}) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => this,
    );
  }

  Widget allPadding(double pad) {
    return Padding(
      padding: EdgeInsets.all(pad),
      child: this,
    );
  }

  Widget onlyPadding({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  WidgetSpan toSpan() => WidgetSpan(child: this);
}
