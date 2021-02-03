import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/constants/colors.dart';
import 'package:habit/flutter/widget/back_button_black.dart';


class Toolbar extends AppBar {
  Toolbar({
    Key key,
    Widget leading:
        const BlackBackButton(),
    bool automaticallyImplyLeading: true,
    Widget title,
    List<Widget> actions,
    Widget flexibleSpace,
    PreferredSizeWidget bottom,
    double elevation: 0.0,
    Color backgroundColor,
    Brightness brightness: Brightness.light,
    IconThemeData iconTheme,
    TextTheme textTheme,
    bool primary: true,
    bool centerTitle,
    double titleSpacing: NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity: 1.0,
    double bottomOpacity: 1.0,
  }) : super(
            key: key,
            leading: leading,
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: DefaultTextStyle(
              child: title ?? Container(),
              style: TextStyle(color: colorWhite, fontSize: 18.0),
            ),
            actions: actions,
            flexibleSpace: flexibleSpace,
            bottom: bottom,
            elevation: elevation,
            backgroundColor: backgroundColor,
            brightness: brightness,
            iconTheme: iconTheme,
            textTheme: textTheme,
            primary: primary,
            centerTitle: centerTitle,
            titleSpacing: titleSpacing,
            toolbarOpacity: toolbarOpacity,
            bottomOpacity: bottomOpacity,
            actionsIconTheme: IconThemeData(color: colorWhite));
}
