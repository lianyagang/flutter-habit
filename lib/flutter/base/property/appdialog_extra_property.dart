import 'package:habit/flutter/base/repeat_value_notifier.dart';

class AppDialogExtraProperty {
  /// 弹窗
  RepeatValueNotifier<DialogProperty> showDialogProperty =
      RepeatValueNotifier(null);

  /// 设置对话框
  void showCustomDialog(
      {String title,
      String content,
      String cancelContent,
      String sureContent,
      Function cancelFun,
      Function sureFun}) {
    final value=_setRest(title:title,content:content,cancelContent:cancelContent,sureContent:sureContent,cancelFun:cancelFun,sureFun:sureFun);
    showDialogProperty.notifyChange(value);
  }

  DialogProperty _setRest(
      {String title,
      String content,
      String cancelContent,
      String sureContent,
      Function cancelFun,
      Function sureFun}) {
    DialogProperty property = DialogProperty();
    property.title = title;
    property.content = content;
    property.cancelContent = cancelContent;
    property.sureContent = sureContent;
    property.cancelFun = cancelFun;
    property.sureFun = sureFun;
    return property;
  }
}

class DialogProperty {
  /// 设置对话框标题
  String title = "";

  /// 设置对话框描述
  String content = "";

  /// 设置对话框取消按钮
  String cancelContent;

  /// 设置对话框确定按钮
  String sureContent;

  /// 取消的回调事件
  Function cancelFun;

  /// 确定的回调事件
  Function sureFun;
}
