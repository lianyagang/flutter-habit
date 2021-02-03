export 'flutter/base/extensions/screen_extension.dart';

import 'dart:async';

import 'package:flutter/services.dart';

export 'view_model.dart';

class Habit {
  static const MethodChannel _channel =
      const MethodChannel('habit');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<String> get go2Login async {
    final String go2Login = await _channel.invokeMethod('go2Login');
    return go2Login;
  }
}
