import 'package:flutter/material.dart';

class RTLHelper {
  static EdgeInsetsGeometry symmetric(BuildContext context, 
      {double horizontal = 0, double vertical = 0}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return EdgeInsets.only(
      left: isRTL ? 0 : horizontal,
      right: isRTL ? horizontal : 0,
      top: vertical,
      bottom: vertical,
    );
  }

  static EdgeInsetsGeometry only(BuildContext context, {
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return EdgeInsets.only(
      left: isRTL ? right : left,
      right: isRTL ? left : right,
      top: top,
      bottom: bottom,
    );
  }

  static AlignmentGeometry alignment(BuildContext context, 
      {bool alignToStart = true}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    if (alignToStart) {
      return isRTL ? Alignment.centerRight : Alignment.centerLeft;
    } else {
      return isRTL ? Alignment.centerLeft : Alignment.centerRight;
    }
  }

  static CrossAxisAlignment crossAxisAlignment(BuildContext context,
      {bool alignToStart = true}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    if (alignToStart) {
      return isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    } else {
      return isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    }
  }

  static MainAxisAlignment mainAxisAlignment(BuildContext context,
      {bool alignToStart = true}) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    if (alignToStart) {
      return isRTL ? MainAxisAlignment.end : MainAxisAlignment.start;
    } else {
      return isRTL ? MainAxisAlignment.start : MainAxisAlignment.end;
    }
  }
}