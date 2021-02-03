import 'package:flutter/material.dart';
import 'package:habit/flutter/constants/colors.dart';

/// 构建一个全屏的按钮
Widget buildMatchParentButton({
  @required String btnTitle,
  @required double btnTitleSp,
  @required VoidCallback onPressed,
  num btnHeight,
  double btnRadius,
  Color color,
  Color disabledColor,
}) {
  return Container(
    child: SizedBox(
      height: btnHeight == null ? 40 : btnHeight,
      child: RaisedButton(
        color: color == null ? color66FFA22D : color,
        disabledColor:
            disabledColor == null ? color66FFA22D : disabledColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        textColor: Colors.white,
        highlightElevation: 0,
        disabledElevation: 0,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(btnRadius == null ? 6.0 : btnRadius),
          ),
        ),
        onPressed: () => {
          if (onPressed != null) {onPressed()}
        },
        child: Text(
          btnTitle,
          style: TextStyle(fontSize: btnTitleSp),
        ),
      ),
    ),
  );
}
