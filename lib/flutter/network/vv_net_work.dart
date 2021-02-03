import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/constant_config.dart';
import 'package:habit/flutter/constants/constants.dart';
import 'package:habit/flutter/constants/http_constants.dart';
import 'package:habit/flutter/network/interceptor/BaseHeadInterceptor.dart';

import 'aes/aes_util.dart';
import 'entity/base_request_entity.dart';
import 'entity/base_response_entity.dart';
import 'http_error.dart';
import 'net_exception.dart';

class VvRequestClient {
  static const String contentType = 'application/json; charset=UTF-8';
  static Map<String, CancelToken> cancelTokens = new Map<String, CancelToken>();

  ///网络请求使用的tag
  String tag;

  ///超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;
  static const int HTTP_SUCCEED = 10000;
  static final VvRequestClient _instance = VvRequestClient._internal();

  factory VvRequestClient() => _instance;
  Dio _client;

  Dio get client => _client;

  /// 创建 dio 实例对象
  VvRequestClient._internal() {
    if (_client == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      _client = Dio();
      _client.interceptors..add(BaseHeadInterceptor());
      if (!isRelease) {
        _client.interceptors
          ..add(LogInterceptor(requestBody: true, responseBody: true)); //开启请求日志
      }
      if (ConstantConfig.localProxy.isNotEmpty) {
        (_client.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
//          if(cert.pem==PEM){ // Verify the certificate
//            return true;
//          }
            return true;
          };
          client.findProxy = (uri) {
            return ConstantConfig.localProxy;
          };
        };
      }
    }
  }

  ///初始化公共属性
  ///
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  void init(
      {int connectTimeout,
      int receiveTimeout,
      List<Interceptor> interceptors}) {
    if (interceptors != null && interceptors.isNotEmpty) {
      _client.interceptors..addAll(interceptors);
    }
  }

  Future<BaseResponseEntity<T>> request<T>(String requestUrl,
      {Map<String, dynamic> queryParameters,
      Map<String, dynamic> header,
      bool isPost = true,
      bool isCancelable = true,
      Options options}) async {
    //设置默认值
    queryParameters = queryParameters ?? {};
    options?.method = isPost ? 'POST' : 'GET';

    options = options ??
        Options(
          method: isPost ? 'POST' : 'GET',
        );

    if (isPost) {
      options.contentType = contentType;
    }

    ///加密
    if (isPost && queryParameters != null) {
      var currentTimeMillis = EncryptUtil.currentTimeMillis();
      var content = json.encode(queryParameters);
      print(content);
      BaseRequestEntity baseRequestBean = new BaseRequestEntity();
      content = EncryptUtil.aesEncode(content);
      baseRequestBean.params = content;
      baseRequestBean.sign = EncryptUtil.getSign(currentTimeMillis, content);
      baseRequestBean.timeStamp = currentTimeMillis;
      queryParameters = baseRequestBean.toJson();
      var encodeData = json.encode(baseRequestBean);
      print(encodeData);
    }
    Response response = await (isPost
        ? _client.post(requestUrl,
            data: queryParameters, cancelToken: cancelTokens[tag])
        : _client.get(requestUrl,
            queryParameters: queryParameters, cancelToken: cancelTokens[tag]));
    if (response.statusCode == HttpStatus.ok) {
      var baseResult = response.data;
      var authorization = response.headers.value('authorization');
      if (authorization != null) {
        authorizationStr = authorization;
      }
      if (baseResult['code'] == HTTP_SUCCEED) {
        var data = baseResult['data'];
        if (data != null) {
          try {
            //解密
            String decodeData = EncryptUtil.aesDecode(data);
            var dynamicData = json.decode(decodeData);
            print('解密后的数据$decodeData');
            BaseResponseEntity<T> baseResEntity = BaseResponseEntity(
                data: dynamicData,
                code: baseResult['code'],
                msg: baseResult['msg'],
                timeStamp: baseResult['timeStamp']);
            return new Future.value(baseResEntity);
          } catch (e) {
            throw (new ResponseException(
                code: baseResult['code'],
                message: e.toString(),
                errorData: baseResult['data']));
          }
        } else {
          throw (new ResponseException(
              code: baseResult['code'],
              message: baseResult['msg'],
              errorData: baseResult['data']));
        }
      } else {
        throw (new ResponseException(
            code: baseResult['code'],
            message: baseResult['msg'],
            errorData: baseResult['data']));
      }
    } else {
      throw (new DioError());
    }
  }

  ///取消请求
  static void cancelHttp(String tag) {
    if (cancelTokens.containsKey(tag)) {
      if (!cancelTokens[tag].isCancelled) {
        cancelTokens[tag].cancel();
      }
      cancelTokens.remove(tag);
    }
  }

  ///异步下载文件
  ///
  ///[url] 下载地址
  ///[savePath]  文件保存路径
  ///[onReceiveProgress]  文件保存路径
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<Response> downloadAsync({
    @required String url,
    @required savePath,
    ProgressCallback onReceiveProgress,
    Map<String, dynamic> params,
    data,
    Options options,
    @required String tag,
  }) async {
    //设置下载不超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);

    //设置默认值
    params = params ?? {};

    url = _restfulUrl(url, params);

    try {
      return _client.download(url, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: params,
          data: data,
          options: options);
    } on DioError catch (e) {
      throw (HttpError.dioError(e));
    } catch (e) {
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  ///上传文件
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[onSendProgress] 上传进度
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> uploadAsync<T>({
    @required String url,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String, dynamic> params,
    Options options,
    @required String tag,
  }) async {
    //设置默认值
    params = params ?? {};

    //强制 POST 请求
    options?.method = 'POST';

    options = options ??
        Options(
          method: 'POST',
        );

    url = _restfulUrl(url, params);

    try {
      Response<Map<String, dynamic>> response = await _client.request(url,
          onSendProgress: onSendProgress,
          data: data,
          queryParameters: params,
          options: options);

      String statusCode = response.data["statusCode"];
      if (statusCode == "0") {
        //成功
        return response.data["data"];
      } else {
        //失败
        String message = response.data["statusDesc"];
        return Future.error((HttpError(statusCode, message)));
      }
    } on DioError catch (e) {
      throw (HttpError.dioError(e));
    } catch (e) {
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }
}

///http请求成功回调
typedef void HttpSuccessCallback<T>(T result);

///失败回调
typedef void HttpFailureCallback(Exception err);
