import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_example/function/remark/refresh_view.dart';

/// 导航栏
/// Created by guoshuyu
/// Date: 2018-07-16

class NavigatorUtils {
  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
//    if (navigator == null) {
//      try {
//        navigator = Navigator.of(context);
//      } catch (e) {
//        error = true;
//      }
//    }
//
//    if (replace) {
//      ///如果可以返回，清空开始，然后塞入
//      if (!error && navigator.canPop()) {
//        navigator.pushAndRemoveUntil(
//          router,
//          ModalRoute.withName('/'),
//        );
//      } else {
//        ///如果不可返回，直接替换当前
//        navigator.pushReplacement(router);
//      }
//    } else {
//      navigator.push(router);
//    }
  }
  ///评论页面
  static goRemarkList(BuildContext context,ValueChanged<dynamic> data) {
    // Navigator.pushReplacementNamed(context, RemarkRefreshPage.sName);
    NavigatorRouter(context, new RemarkRefreshPage('ok'),data);

  }
  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }


  ///公共打开方式
  static NavigatorRouter(BuildContext context, Widget widget,ValueChanged<dynamic> data) {
    return Navigator.push(context,
        new CupertinoPageRoute(builder: (context) => pageContainer(widget))).then((value) => data(value));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(

      ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }
}
