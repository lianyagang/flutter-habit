import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ScreenUtils {
  static MediaQueryData _mediaQuery;

  static double _width;
  static double _height;
  static double _topbarH;
  static double _botbarH;
  static double _pixelRatio;
  static double _ratio = 0;

  static void init(BoxConstraints constraints, int number) {
    var window = WidgetsBinding.instance?.window ?? ui.window;
    if (window == null) {
      throw Exception(
          'get window instance not work, please look up ScreenUtils');
    }
    _mediaQuery = MediaQueryData.fromWindow(window);
    if (_mediaQuery == null) {
      throw Exception(
          'get MediaQueryData instance not work, please look up ScreenUtils');
    }
    var size = _mediaQuery.size;
    _width = size.width;
    _height = size.height;
    _topbarH = _mediaQuery.padding.top;
    _botbarH = _mediaQuery.padding.bottom;
    _pixelRatio = _mediaQuery.devicePixelRatio;
    _ratio = size.width / number;
  }

  static px(number) {
    if (_ratio == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return number * _ratio;
  }

  static onePx() {
    if (_pixelRatio == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return 1 / _pixelRatio;
  }

  static screenW() {
    if (_width == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return _width;
  }

  static screenH() {
    if (_height == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return _height;
  }

  static padTopH() {
    if (_topbarH == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return _topbarH;
  }

  static padBotH() {
    if (_botbarH == 0) {
      throw Exception('please init ScreenUtils init function');
    }
    return _botbarH;
  }

  static navigationBarHeight() {
    if (_mediaQuery == null) {
      throw Exception(
          '_mediaQuery must not null,please init ScreenUtils init function');
    }
    return _mediaQuery.padding.top + kToolbarHeight;
  }
}
