import 'package:flutter/material.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:habit/habit.dart';


class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final BaseViewModel appBarProperty;

  AppBarWidget(this.appBarProperty);

  @override
  Widget build(BuildContext context) {
    return ValueListenableListBuilder(
      valueListenables: [
        appBarProperty.appBarTitle,
        appBarProperty.appBarShowBackIcon,
        appBarProperty.appBarBackIconColor,
        appBarProperty.appBarTitleColor,
        appBarProperty.appBarTitleSize,
        appBarProperty.appBarBgColor,
        appBarProperty.appBarBrightness,
        // appBarProperty.appBarLeadingCallBack
      ],
      builder: (context, value, child) {
        return AppBar(
          brightness: appBarProperty.appBarBrightness.value,
          backgroundColor: appBarProperty.appBarBgColor.value==null
              ? Theme.of(context).accentColor
              : appBarProperty.appBarBgColor.value,
          elevation: 0,
          centerTitle: true,
          title: Text(
            appBarProperty.appBarTitle.value,
            style: TextStyle(
              fontSize: appBarProperty.appBarTitleSize.value,
              color: appBarProperty.appBarTitleColor.value,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Visibility(
            visible: appBarProperty.appBarShowBackIcon.value,
            child: IconButton(
              onPressed: () {
                // appBarProperty.appBarLeadingCallBack.value?.call();
                ///执行默认的返回按钮
                if (appBarProperty.appBarLeadingCallBack.value == null) {
                  Navigator.pop(context);
                } else {
                  appBarProperty.appBarLeadingCallBack.value.call();
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: appBarProperty.appBarBackIconColor.value,
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
