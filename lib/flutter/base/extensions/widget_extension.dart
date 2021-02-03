import 'package:flutter/widgets.dart';

extension WidgetListExtndsion on List<Widget> {

  //删除空Widget
  List<Widget> removeNullWidget() => this.where((element) => element != null).toList();
}