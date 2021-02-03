import 'package:flutter/material.dart';
import 'package:habit_example/global/user.dart'; //ChangeNotifier需要material素材库

class UserInfo extends ChangeNotifier {

  UserModel _info;
  UserModel get info => _info ?? null;
// APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => info != null;
  void setInfo(info) {
    _info = UserModel.fromJson(info);
    notifyListeners();
  }


}
