import 'package:flutter/material.dart' hide Action;
import 'package:oktoast/oktoast.dart';

class EmptyWidget extends StatelessWidget {
  final Color retryTextColor;
  final Color titleTextColor;
  final Widget child;
  final Icon icon;
  final String titleText;
  final String retryText;
  final bool showRetry;

  const EmptyWidget({
    Key key,
    this.retryTextColor = const Color(0xFFFFE306),
    this.titleTextColor = const Color(0xFFFFE306),
    this.icon = const Icon(Icons.ac_unit),
    this.titleText = '网络异常啦啦啦',
    this.retryText = '重试',
    this.showRetry = true,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  titleText,
                  style: TextStyle(fontSize: 18.0, color: titleTextColor),
                ),
              ),
              Visibility(
                  visible: showRetry,
                  child: RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(22.0),
                          side: new BorderSide()),
                      child: Text(
                        retryText,
                        style: TextStyle(fontSize: 18.0, color: retryTextColor),
                      ),
                      color: Colors.transparent,
                      textColor: retryTextColor,
                      onPressed: () {
                        //需要使用Action回调到相关外部逻辑处理
                        showToast('需要使用Action回调到相关外部逻辑处理');
                      }))
            ],
          )),
    );
  }
}
