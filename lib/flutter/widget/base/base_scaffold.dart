import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/base/property/empty_state_model.dart';
import 'package:habit/flutter/utils/keyboard_utils.dart';
import 'package:habit/flutter/widget/base/base_appbar_widget.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:habit/flutter/widget/dialog/common_dialog.dart';
import 'package:habit/flutter/widget/empty_state_widget.dart';

typedef void PageStateCallBack<PageState>(PageState pageState);

///页面生命周期
enum PageState {
  RESUMED,
  INACTIVE,
  PAUSED,
  DETACHED,
}

class BaseScaffold<VM extends BaseViewModel> extends StatefulWidget {
  /// 要渲染的布局
  final Widget body;

  /// 页面生命周期
  final PageStateCallBack<PageState> pageState;

  /// ViewModel 相关信息
  final VM viewModel;

  /// 设置ToolBar
  final Widget toolBar;

  BaseScaffold({
    Key key,
    this.pageState,
    @required this.body,
    @required this.viewModel,
    this.toolBar,
  }) : super(key: key);

  @override
  _BaseScaffoldState<VM> createState() => _BaseScaffoldState<VM>();
}

class _BaseScaffoldState<VM extends BaseViewModel> extends State<BaseScaffold>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _addDialogObserver();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        if (widget.pageState != null) {
          widget.pageState(PageState.INACTIVE);
        }
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        if (widget.pageState != null) {
          widget.pageState(PageState.RESUMED);
        }
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        if (widget.pageState != null) {
          widget.pageState(PageState.PAUSED);
        }

        break;
      case AppLifecycleState.detached: // 申请将暂时暂停
        if (widget.pageState != null) {
          widget.pageState(PageState.DETACHED);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.viewModel.globalBgColor.value,
      resizeToAvoidBottomInset: false,
      appBar: _findCurrentToolBar(),
      body: WillPopScope(
        onWillPop: () {
          if (widget.viewModel.appBarLeadingCallBack.value == null) {
            return Future.value(true);
          } else {
            return widget.viewModel.appBarLeadingCallBack.value.call();
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            KeyboardUtils.hideByContext(context);
          },
          child: ValueListenableBuilder<EmptyState>(
            valueListenable: widget.viewModel.emptyState,
            builder: (context, state, _) => state == EmptyState.NORMAL
                ? widget.body
                : BaseEmptyStateWidget<VM>(
                    toolBar: widget.toolBar,
                  ),
          ),
        ),
      ),
    );
  }

  /// 获取当前的Toolbar的参数
  Widget _findCurrentToolBar() {
    /// 优先显示设置的toolBar
    if (widget.toolBar != null) {
      return widget.toolBar;
    }

    /// 显示默认的toolbar
    if (widget.toolBar == null && widget.viewModel.appBarIsShow) {
      return AppBarWidget(widget.viewModel);
    }
    return null;
  }

  /// 添加对话框的监听
  void _addDialogObserver() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (mounted) {
          widget.viewModel.showDialogProperty.addListener(
            () {
              showDialog<Null>(
                context: context, //BuildContext对象
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CommonDialog(
                    title: widget.viewModel.showDialogProperty.value.title,
                    message: widget.viewModel.showDialogProperty.value.content,
                    negativeText:
                        widget.viewModel.showDialogProperty.value.cancelContent,
                    positiveText:
                        widget.viewModel.showDialogProperty.value.sureContent,
                    onPositivePressEvent: () {
                      Navigator.pop(context);
                      widget.viewModel.showDialogProperty.value.sureFun?.call();
                    },
                    onCloseEvent: () {
                      Navigator.pop(context);
                      widget.viewModel.showDialogProperty.value.cancelFun
                          ?.call();
                      // Navigator.pop(context);
                    },
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
