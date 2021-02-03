import 'dart:io';

import 'package:dio/dio.dart';
import 'package:habit/flutter/constants/http_constants.dart';
import 'package:habit/flutter/network/system_utils.dart';
import 'package:habit/flutter/utils/sp_utils/sp_constant.dart';
import 'package:habit/flutter/utils/sp_utils/sp_utils.dart';

///请求头拦截器
class BaseHeadInterceptor extends InterceptorsWrapper {
  static const String contentType = 'application/json; charset=UTF-8';

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  @override
  onRequest(RequestOptions options) async {
    ///超时
    options.baseUrl = baseUrl;
    options.connectTimeout = CONNECT_TIMEOUT;
    options.receiveTimeout = RECEIVE_TIMEOUT;
    options.headers = {
      HttpHeaders.userAgentHeader: userAgent,
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.acceptLanguageHeader: SystemUtils.getAppLanguageAndReg(),
      HttpHeaders.authorizationHeader: authorizationStr,
      'os': Platform.operatingSystem,
      'version': appVersion,
      'X-Channel': appChannel,
      'smode': 1,
    };
    return options;
  }

  String getData() {
    return SpUtils.getString(SpConstants.authorization);
  }
}
