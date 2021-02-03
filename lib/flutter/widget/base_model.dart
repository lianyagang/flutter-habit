import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit/flutter/network/vv_net_work.dart';
import 'package:habit/flutter/widget/IModel.dart';

class BaseModel implements IModel {
  VvRequestClient apiService;

  CancelToken _cancelToken = new CancelToken();
  String randomId;

  BaseModel() {
    randomId = _randomBit(100);
    print('初始化的数据$randomId.');
    this.apiService = VvRequestClient();
    apiService.tag = randomId;
    VvRequestClient.cancelTokens[randomId] = _cancelToken;
  }

  @override
  void onClear() {
    print('取消的数据$randomId');
    //界面销毁，取消网络请求
    VvRequestClient.cancelHttp(randomId);
  }

  ///获取随机数
  String _randomBit(int len) {
    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }
}
