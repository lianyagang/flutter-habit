import 'dart:collection';

import 'package:pigeon/pigeon.dart';

import 'base_factory.dart';

/// 生成代码
/// cd vv_life_pigeon
/// flutter pub run pigeon --input test/pigeon/router_finish_factory.dart
///
///
void configurePigeon(PigeonOptions options) {
  configFactoryInfo(options, "router_finish", "RouterFinish");
}



@HostApi()
abstract class RouterFinishManager{
  /// 结束当前界面
  void notifyFinishCurrentPage();}
