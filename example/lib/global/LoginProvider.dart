import 'package:flutter/cupertino.dart';
import 'package:habit_example/common/utils/navigator_utils.dart';
import 'package:habit_example/function/login/login_view.dart';

class LoginProvider extends ChangeNotifier {
  ///是否登录
  bool login;

  void go2Login(BuildContext _context) {
    if (!login) {
      NavigatorUtils.pushNamed(_context, LoginViewPage.sName);
    }
  }
}
