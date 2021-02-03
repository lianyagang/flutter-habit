import 'package:flutter/material.dart';
import 'package:habit/flutter/constants/colors.dart';

/// 创建一个字体大小为16sp且加粗的字体样式
Widget build16SpFontBoldText({@required String content}) {
  return Text(
    content,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

///构建一个指定属性的文本
Widget buildFontTextByProperty({
  @required String content,
  num fontSize,
  bool isBold = false,
  Color color,
}) {
  return Text(
    content,
    style: TextStyle(
      fontSize: fontSize == null ? 16 : fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color == null ? color333333 : color,
    ),
  );
}

/// 构建一个可点击的文本
Widget buildClickText({
  @required String content,
  @required GestureTapCallback onTap,
  num fontSize,
  Color color,
}) {
  return InkWell(
    child: Text(
      content,
      style: TextStyle(
          fontSize: fontSize == null ? 13 : fontSize,
          color: color == null ? colorB2B2B2 : color),
    ),
    onTap: onTap,
  );
}
