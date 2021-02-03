import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:habit/flutter/constants/colors.dart';
import 'package:habit/flutter/widget/flex_button.dart';
import 'package:lottie/lottie.dart';
import 'package:habit/habit.dart';
/// 通用逻辑
/// Created by lianyagang
/// Date: 2020-12-1

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale curLocale;

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTimes =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTimes < MILLIS_LIMIT) {
      return (curLocale != null)
          ? (curLocale.languageCode != "zh")
              ? "right now"
              : "刚刚"
          : "刚刚";
    } else if (subTimes < SECONDS_LIMIT) {
      return (subTimes / MILLIS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh")
                  ? " seconds ago"
                  : " 秒前"
              : " 秒前");
    } else if (subTimes < MINUTES_LIMIT) {
      return (subTimes / SECONDS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh")
                  ? " min ago"
                  : " 分钟前"
              : " 分钟前");
    } else if (subTimes < HOURS_LIMIT) {
      return (subTimes / MINUTES_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh")
                  ? " hours ago"
                  : " 小时前"
              : " 小时前");
    } else if (subTimes < DAYS_LIMIT) {
      return (subTimes / HOURS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh")
                  ? " days ago"
                  : " 天前"
              : " 天前");
    } else {
      return getDateStr(date);
    }
  }

  static String removeTextTag(String description) {
    if (description != null) {
      String reg = "<g-emoji.*?>.+?</g-emoji>";
      RegExp tag = new RegExp(reg);
      Iterable<Match> tags = tag.allMatches(description);
      for (Match m in tags) {
        String match = m
            .group(0)
            .replaceAll(new RegExp("<g-emoji.*?>"), "")
            .replaceAll(new RegExp("</g-emoji>"), "");
        description = description.replaceAll(new RegExp(m.group(0)), match);
      }
    }
    return description;
  }

  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  static getFullName(String repositoryUrl) {
    if (repositoryUrl != null &&
        repositoryUrl.substring(repositoryUrl.length - 1) == "/") {
      repositoryUrl = repositoryUrl.substring(0, repositoryUrl.length - 1);
    }
    String fullName = '';
    if (repositoryUrl != null) {
      List<String> splicer = repositoryUrl.split("/");
      if (splicer.length > 2) {
        fullName =
            splicer[splicer.length - 2] + "/" + splicer[splicer.length - 1];
      }
    }
    return fullName;
  }

  static getThemeData(Color color) {
    return ThemeData(primarySwatch: color, platform: TargetPlatform.android);
  }

  ///获取设备信息
  static Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return "";
    }
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.model;
  }

  static const IMAGE_END = [".png", ".jpg", ".jpeg", ".gif", ".svg"];

  static isImageEnd(path) {
    bool image = false;
    for (String item in IMAGE_END) {
      if (path.indexOf(item) + item.length == path.length) {
        image = true;
      }
    }
    return image;
  }
  ///隐藏loading
  static disMissLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }

  ///显示loading
  static Future<Null> showLoadingDialog(BuildContext context,
      {bool barrierDismissible = false}) {
    return showGSYDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                  onWillPop: () => new Future.value(false),
                  child: Container(
                    child: Center(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: color99000000,
                              ),
                              child: SizedBox(
                                  width: 110.px,
                                  height: 110.px,
                                  child: Lottie.asset(
                                      "assets/json/lottie_loading.json",
                                      fit: BoxFit.contain,
                                      package: 'habit')),
                            )
                          ], //.where((element) => element != null).toList(),
                        ),
                      ),
                    ),
                  )));
        });
  }

  ///弹出 dialog
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: new SafeArea(child: builder(context)));
        });
  }

  ///列表item dialog
  static Future<Null> showCommitOptionDialog(
    BuildContext context,
    List<String> commitMaps,
    ValueChanged<int> onTap, {
    width = 250.0,
    height = 400.0,
    List<Color> colorList,
  }) {
    return showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: new Container(
              width: width,
              height: height,
              padding: new EdgeInsets.all(4.0),
              margin: new EdgeInsets.all(20.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                //用一个BoxDecoration装饰器提供背景图片
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: new ListView.builder(
                  itemCount: commitMaps.length,
                  itemBuilder: (context, index) {
                    return BaseFlexButton(
                      maxLines: 1,
                      mainAxisAlignment: MainAxisAlignment.start,
                      fontSize: 14.0,
                      color: colorList != null
                          ? colorList[index]
                          : Theme.of(context).primaryColor,
                      text: commitMaps[index],
                      textColor: Colors.white,
                      onPress: () {
                        Navigator.pop(context);
                        onTap(index);
                      },
                    );
                  }),
            ),
          );
        });
  }
}
