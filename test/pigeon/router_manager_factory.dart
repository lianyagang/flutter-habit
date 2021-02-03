import 'dart:collection';

import 'package:pigeon/pigeon.dart';

import 'base_factory.dart';

/// 生成代码
/// cd vv_life_pigeon
/// flutter pub run pigeon --input test/pigeon/weather.dart
///
///
void configurePigeon(PigeonOptions options) {
  configFactoryInfo(options, "router_manager", "RouterManager");
}

class FlutterRouterParam {
  String path;
  Map params;
}

@HostApi()
abstract class FlutterRouterManager{
  /// 通知跳转
  void notifyNavigatorPath(FlutterRouterParam params);
}
