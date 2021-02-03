import 'package:pigeon/pigeon.dart';

import 'base_factory.dart';


/// 生成代码
/// flutter pub run pigeon --input test/pigeon/login_authority_factory.dart
///
///
void configurePigeon(PigeonOptions options) {
  configFactoryInfo(options, "login_authority", "VVFlutterLoginAuthority");
}

class AuthorityAction {
  String action;
}

@HostApi()
abstract class FlutterLoginAuthority {
  /// 通知原生界面需要重新登录
  void notifyAuthorityAction(AuthorityAction request);
}
