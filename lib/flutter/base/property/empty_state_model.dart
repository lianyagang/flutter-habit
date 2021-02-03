import 'package:habit/habit.dart';
import 'package:habit/flutter/utils/window_utils.dart';

import 'empty_constant.dart';

///缺省页页面布局类型
enum PageType {
  /// 全屏（无标题栏）
  FULL,

  /// 正常页面（包含标题栏）
  NORMAL,

  /// 页面缺省页展示区域非常小
  SMALL,
}

///重试按钮展示逻辑
enum ReloadType {
  ///不展示重试按钮
  NONE,

  ///网络错误
  NET_ERROR,

  ///无数据展示重试按钮
  EMPTY,

  ///网络异常、无数据都展示重试按钮
  BOTH,
}

///缺省页状态
enum EmptyState {
  /// 正常
  NORMAL,

  /// 显示进度条
  PROGRESS,

  ///列表数据为空
  EMPTY,

  ///网络未连接
  NET_ERROR,

  ///服务器不可用
  NOT_AVAILABLE,
}

///缺省页Model
class EmptyModel {
  ValueNotifier<EmptyState> emptyState = ValueNotifier(EmptyState.NORMAL);

  ValueNotifier<ReloadType> reloadType = ValueNotifier(ReloadType.BOTH);

  String resPackage = 'habit';

  ///loading 资源
  String loadingAsset = 'assets/json/lottie_loading.json';

  /// 空数据页面 资源
  String get emptyIconRes {
    switch (emptyState.value) {
      case EmptyState.EMPTY:
        return _icon != null ? _icon : defaultEmptyDrawable;
      case EmptyState.NET_ERROR:
        return _icon != null ? _icon : networkErrorDrawable;
      default:
        return '';
    }
  }

  ///隐藏缺省页的ToolBar
  bool hideStateToolBar = false;

  ///标题
  String get currentStateLabel {
    switch (emptyState.value) {
      case EmptyState.EMPTY:
        return _title != null ? _title : defaultEmptyDrawable;
      case EmptyState.NET_ERROR:
        return _title != null ? _title : networkErrorTitle;
      case EmptyState.NOT_AVAILABLE:
        return _title != null ? _title : defaultServerNotAvailable;
      default:
        return '';
    }
  }

  ///副标题
  String get currentNotifyStateLabel {
    switch (emptyState.value) {
      case EmptyState.EMPTY:
        return _subTitle != null ? _subTitle : _subTitle;
      case EmptyState.NET_ERROR:
        return _subTitle != null ? _subTitle : networkErrorMsg;
      default:
        return '';
    }
  }

  /// 重试按钮文案
  String get reloadStr {
    switch (emptyState.value) {
      case EmptyState.EMPTY:
        return emptyReloadStr;
      case EmptyState.NET_ERROR:
        return errorReloadStr;
      case EmptyState.NOT_AVAILABLE:
        return errorReloadStr;
      default:
        return '';
    }
  }

  ///是否显示重试按钮逻辑
  bool get showReload {
    switch (emptyState.value) {
      case EmptyState.EMPTY:
        return reloadType.value == ReloadType.EMPTY ||
            reloadType.value == ReloadType.BOTH;
      case EmptyState.NET_ERROR:
      case EmptyState.NOT_AVAILABLE:
        return reloadType.value == ReloadType.NET_ERROR ||
            reloadType.value == ReloadType.BOTH;
      default:
        return false;
    }
  }

  /// 网络异常时显示的重试文案
  String errorReloadStr = defaultReloadErrorStr;

  /// 无网络时显示的重试文案
  String emptyReloadStr = defaultReloadErrorStr;

  ///缺省页顶部间距
  ValueNotifier<double> marginTop = ValueNotifier(80.0);

  /// 16:9的相对准确值
  double _rate_16_9 = 1.77;

  /// 是否显示副标题
  bool isShowErrorTitle = true;

  set pageType(PageType value) {
    switch (value) {
      case PageType.FULL:
        marginTop.value = _isMore16To9() ? 156.0 : 128.0;
        break;
      case PageType.SMALL:
        marginTop.value = _isMore16To9() ? 40.0 : 32.0;
        break;
      default:
        marginTop.value = _isMore16To9() ? 80.0 : 66.0;
        break;
    }
  }

  EmptyState get mState => emptyState.value;

  set mState(EmptyState value) {
    emptyState.value = value;
  }

  ///传参标题
  String _title;

  ///传参副标题
  String _subTitle;

  ///传参图片资源
  String _icon;

  ///设置状态以及自定义显示文案
  void setEmptyState(
      EmptyState value, String title, String subTitle, String icon) {
    this._title = title;
    this._subTitle = subTitle;
    this._icon = icon;
    emptyState.value = value;
  }

  /// Desc: 设置重试按钮显示逻辑
  /// <p>
  /// Author: lianyagang
  /// Date: 2020/12/1
  ///
  /// @param errorReloadStr 网络异常时显示的重试文案，没传或者null使用默认文案
  /// @param emptyReloadStr 空数据时显示的重试文案，没传或者null使用默认文案
  void setReloadType(
      ReloadType reloadType, String errorReloadStr, String emptyReloadStr) {
    this.reloadType.value = reloadType;
    if (errorReloadStr != null) {
      this.errorReloadStr = errorReloadStr;
    }
    if (emptyReloadStr != null) {
      this.emptyReloadStr = emptyReloadStr;
    }
  }

  bool _isMore16To9() =>
      WindowUtils.getScreenHeight() / WindowUtils.getScreenWidth() >=
      _rate_16_9 + 0.05;

  ///显示loading
  void showLoading() {
    mState = EmptyState.PROGRESS;
  }

  ///显示正常布局
  void showNormal() {
    mState = EmptyState.NORMAL;
  }

  ///显示网络错误
  void showNetError() {
    mState = EmptyState.NET_ERROR;
  }

  ///显示数据为空布局
  void showEmpty() {
    mState = EmptyState.EMPTY;
  }

  ///触发刷新
  void executeChangeNotify() {}

  ///重试按钮
  void onReloadData() {}
}
