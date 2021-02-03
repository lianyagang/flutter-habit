import 'package:flutter/material.dart';
import 'package:habit/flutter/widget/base/base_scaffold.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget child;
  final Function(T) onModelReady;
  final T viewModel;
  /// 设置ToolBar
  final Widget toolBar;


  ///强制获取最新的 BaseViewModel
  final bool focusUpdate;

  BaseWidget({
    Key key,
    this.child,
    this.onModelReady,
    this.viewModel,
    this.focusUpdate = false,
    this.toolBar,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    _model = widget.viewModel;

    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.focusUpdate) {
      _model = widget.viewModel;
    }
    return ChangeNotifierProvider.value(
      value: _model,
      child: BaseScaffold<T>(
        body: widget.child,
        toolBar: widget.toolBar,
        viewModel: _model,
      ),
    );
  }
}
