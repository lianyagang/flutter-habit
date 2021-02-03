import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/base/property/appbar_extra_property.dart';
import 'package:habit/flutter/base/property/appdialog_extra_property.dart';
import 'package:habit/flutter/base/property/empty_state_model.dart';
import 'package:habit/flutter/network/http_error.dart';
import 'package:habit/flutter/network/vv_net_work.dart';

import 'base_model.dart';

class BaseViewModel<T extends BaseModel> extends ChangeNotifier
    with EmptyModel, AppBarExtraProperty, AppDialogExtraProperty {

  /// 设置页面的全局背景色
  final ValueNotifier<Color> globalBgColor = ValueNotifier(Colors.white);

  final T model;

  bool _disposed = false;

  bool get disposed => _disposed;

  bool _focusUpdate = false;

  bool get focusUpdate => _focusUpdate;

  set focusUpdate(bool value) {
    _focusUpdate = value;
    notifyListeners();
  }

  BaseViewModel(this.model) {
    pageType = PageType.NORMAL;
  }

  @override
  void dispose() {
    _disposed = true;
    if (model != null && model is BaseModel) {
      model.onClear();
    }
    super.dispose();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  void launch(Future<void> Function() future, HttpFailureCallback err,
      {bool ignoreToast = false,
      bool showLoadingIndicator = false,
      bool isCancelable = true}) {
    future().catchError((onError) {
      ///错误所有的网络异常
      print("啥错误${onError.toString()}");
      err.call(Exception(
          HttpError.checkNetError(onError, ignoreToast: ignoreToast)));
    });
  }

  @override
  void executeChangeNotify() {
    notifyListeners();
  }

  void focusUpdateWidget() {
    focusUpdate = true;
    _focusUpdate = false;
  }
}
