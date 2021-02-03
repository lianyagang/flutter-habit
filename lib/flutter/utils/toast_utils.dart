import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:habit/habit.dart';

class ToastUtils {
  /// 3.5秒
  static final int _LONG_DURATION = 3500;

  /// 2秒
  static final int _SHORT_DURATION = 2000;

  /// 通用的显示吐司方法，显示时长2秒
  static void showShort(String text,
      {BuildContext context,
      ToastPosition position,
      TextStyle textStyle,
      EdgeInsetsGeometry textPadding,
      Color backgroundColor,
      double radius,
      VoidCallback onDismiss,
      TextDirection textDirection,
      bool dismissOtherToast,
      TextAlign textAlign,
      OKToastAnimationBuilder animationBuilder,
      Duration animationDuration,
      Curve animationCurve}) {
    _show(text,
        dismissOtherToast: dismissOtherToast,
        context: context,
        duration: Duration(milliseconds: _SHORT_DURATION),
        position: position,
        backgroundColor: backgroundColor,
        radius: radius,
        onDismiss: onDismiss,
        textDirection: textDirection,
        textAlign: textAlign,
        animationBuilder: animationBuilder,
        animationDuration: animationDuration,
        animationCurve: animationCurve);
  }

  /// 通用的显示吐司方法，显示时长3.5秒
  static void showLong(String text,
      {BuildContext context,
      ToastPosition position,
      TextStyle textStyle,
      EdgeInsetsGeometry textPadding,
      Color backgroundColor,
      double radius,
      VoidCallback onDismiss,
      TextDirection textDirection,
      bool dismissOtherToast,
      TextAlign textAlign,
      OKToastAnimationBuilder animationBuilder,
      Duration animationDuration,
      Curve animationCurve}) {
    _show(text,
        dismissOtherToast: dismissOtherToast,
        context: context,
        duration: Duration(milliseconds: _LONG_DURATION),
        position: position,
        backgroundColor: backgroundColor,
        radius: radius,
        onDismiss: onDismiss,
        textDirection: textDirection,
        textAlign: textAlign,
        animationBuilder: animationBuilder,
        animationDuration: animationDuration,
        animationCurve: animationCurve);
  }

  static void _show(String text,
      {BuildContext context,
      Duration duration,
      ToastPosition position,
      Color backgroundColor,
      double radius,
      VoidCallback onDismiss,
      TextDirection textDirection,
      bool dismissOtherToast,
      TextAlign textAlign,
      OKToastAnimationBuilder animationBuilder,
      Duration animationDuration,
      Curve animationCurve}) {
    showToast(text,
        textStyle: TextStyle(fontSize: 14.px),
        textPadding: EdgeInsets.only(
            left: 30.px, right: 30.px, top: 10.px, bottom: 10.px),
        dismissOtherToast: dismissOtherToast ?? true,
        backgroundColor: Color(0xBD000000),
        radius: 8.0,
        context: context,
        duration: duration,
        position: position,
        onDismiss: onDismiss,
        textDirection: textDirection,
        textAlign: textAlign,
        animationBuilder: animationBuilder,
        animationDuration: animationDuration,
        animationCurve: animationCurve);
  }
}
