
import 'package:habit/flutter/constants/http_constants.dart';

class SystemUtils{

  ///   获取当前应用使用的语言和区域
  ///
  /// 例如：当前设置的是“中文-中国”，则返回“zh-CN,zh;q=0.9”
  static String getAppLanguageAndReg(){
    String appLanguage=currentLanguage;
    String en = "en";
    String weightLanguage = ";q=0.9";
    ///除了英文的情况下，添加
    if (appLanguage.isNotEmpty && appLanguage.toLowerCase()!=en) {
      weightLanguage = ";q=0.9,en;q=0.8";
    }
    return "$appLanguage-CN," + currentLanguage   + weightLanguage;
  }
}