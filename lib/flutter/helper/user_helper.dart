import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/local_user.dart';

class UserHelper {
  static Future<LocalUser> initLocalUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user");
    if (user != null) {
      return LocalUser.fromJson(json.decode(user));
    }
    return null;
  }

  static bool isLogin() {
  }

  static LocalUser getOnlineUser() {
  }

  static setLogin(LocalUser autoEntity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(autoEntity.toJson()));
  }

  static loginCheck(BuildContext context, VoidCallback block) {
    var loginStatus = isLogin();
    //可能为null
    if (loginStatus) {
      block();
    } else {
      logout(context);
    }
  }

  //context为null,就不跳转到登录
  static void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", null);
    /*Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return AppRoute.getPage(PageConstants.AutoPage);
            }), (route) {
      return null == route;
    });*/

    //跳转到登录页面
//    if (context != null &&
//        ModalRoute.of(context).settings.name != PageConstants.AutoPage) {
//      NavigatorHelper.pushPageLoginPage(context);
//    }
  }

  static String getUserToken() {
    return getOnlineUser()?.token ?? "";
  }
}
