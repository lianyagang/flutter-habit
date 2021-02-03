import 'package:flutter/material.dart';
import 'package:habit/habit.dart';

class CommonDialog extends Dialog {
  final String title;
  final String message;
  final String negativeText;
  final String positiveText;
  final Function onCloseEvent;
  final Function onPositivePressEvent;
  final border = BorderSide(
      color: Color(0xFFD7D7D7), width: 0.5.px, style: BorderStyle.solid);

  CommonDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(42.0),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 24.px),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.px,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.px),
                    constraints: BoxConstraints(minHeight: 95.px),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 14.px,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton());
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton());
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: widgets,
      ),
    );
  }

  Widget _buildBottomCancelButton() {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        decoration: BoxDecoration(border: Border(top: border)),
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: onCloseEvent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 17.px, 0, 16.px),
            child: Text(
              negativeText,
              style: TextStyle(
                fontSize: 16.px,
                fontWeight: FontWeight.w500,
                color: Color(0xff999999),
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton() {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        decoration: BoxDecoration(border: Border(top: border, left: border)),
        child: FlatButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: onPositivePressEvent,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 17.px, 0, 16.px),
            child: Text(
              positiveText,
              style: TextStyle(
                fontSize: 16.px,
                fontWeight: FontWeight.w500,
                color: Color(0xffFFA22D),
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
