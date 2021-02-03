import 'package:habit/flutter/constants/constants.dart';

class LogUtils {
  static final String _tag = "flutter----";

  /// 输出相关信息
  static void d(dynamic msg) {
    if (!isRelease) {
      print('$_tag $msg');
    }
  }
}
