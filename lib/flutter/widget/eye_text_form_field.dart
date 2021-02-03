import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:habit/flutter/constants/colors.dart';

class EyeTextFormField extends StatefulWidget {
  final Key textFormKey;

  ///默认是否明文显示
  final bool initSeeEye;

  ///是否密码
  final bool isPwd;

  ///是否显示删除按钮
  final bool initSeeDelete;
  final TextEditingController controller;
  final String initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextStyle style;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final bool autovalidate;
  final bool maxLengthEnforced;
  final int maxLines;
  final int maxLength;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;

  ///显示校验错误的样式
  final bool hideErrorStyle;
  final bool enableInteractiveSelection;
  final ValueChanged<String> onChanged;
  final InputCounterWidgetBuilder buildCounter;

  EyeTextFormField({
    Key key,
    this.controller,
    this.onChanged,
    this.isPwd = false,
    this.hideErrorStyle = true,
    this.initSeeEye = false,
    this.initSeeDelete = false,
    this.textFormKey,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.autovalidate = false,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.maxLength,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.buildCounter,
  }) : super(key: key);

  @override
  _EyeTextFormFieldState createState() => _EyeTextFormFieldState();
}

class _EyeTextFormFieldState extends State<EyeTextFormField> {
  bool seeEye;
  bool seeDelete;
  bool visible;
  bool isPwd;
  bool hideErrorStyle;
  bool deleteHideErrorStyle;
  bool hasFocus = false;
  FocusNode focusNode;
  ValueChanged<String> onChanged;

  @override
  void initState() {
    super.initState();
    seeEye = widget.initSeeEye;
    onChanged = widget.onChanged;
    seeDelete = widget.initSeeDelete;
    hideErrorStyle = widget.hideErrorStyle;
    deleteHideErrorStyle = false;
    visible = false;
    isPwd = widget.isPwd;
    focusNode = widget.focusNode ?? new FocusNode();
    //输入框焦点
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        hasFocus = false;
      } else {
        hasFocus = true;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.unfocus();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hideErrorStyle = (widget.hideErrorStyle || deleteHideErrorStyle);
    deleteHideErrorStyle = false;
    var decoration = (widget.decoration ?? InputDecoration()).copyWith(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: hideErrorStyle || !seeDelete ? colore3e3e3 : colorFF6000),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: hideErrorStyle || !seeDelete ? colore3e3e3 : colorFF6000),
        ),
        suffixIcon: visible
            ? new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  seeDelete && hasFocus
                      ? IconButton(
                          iconSize: 20,
                          constraints: BoxConstraints(),
                          icon: new Image.asset(
                            hideErrorStyle
                                ? 'images/widget_edit_text_delete.png'
                                : 'images/widget_edit_text_wrong.png',
                          ),
                          onPressed: () {
                            if (hideErrorStyle) {
                              setState(() {
                                widget.controller.text = '';
                                if (widget.onChanged != null) {
                                  widget.onChanged('');
                                }
                                seeDelete = (widget.controller.text.isNotEmpty);
                              });
                            }
                          })
                      : new Container(
                          width: 0,
                          height: 0,
                        ),
                  (seeDelete && (isPwd || !hideErrorStyle))
                      ? IconButton(
                          iconSize: 20,
                          constraints: BoxConstraints(),
                          alignment: Alignment.center,
                          icon: new Image.asset(
                            !isPwd
                                ? hasFocus
                                    ? 'images/widget_edit_text_delete.png'
                                    : 'images/widget_edit_text_wrong.png'
                                : seeEye
                                    ? 'images/widget_password_show.png'
                                    : 'images/widget_password_hide.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isPwd) {
                                seeEye = !seeEye;
                              } else if (hasFocus) {
                                hideErrorStyle = true;
                                widget.controller.text = '';
                                if (widget.onChanged != null) {
                                  widget.onChanged('');
                                }
                                seeDelete = (widget.controller.text.isNotEmpty);
                              }
                            });
                          })
                      : new Container(width: 0, height: 0),
                ],
              )
            : new Container(
                width: 0,
                height: 0,
              ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnimatedOpacity(
            curve: Curves.linear,
            opacity: seeDelete ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 12.0, bottom: 0.0),
              child: Text(
                decoration.hintText,
                style: TextStyle(
                    fontSize: 10,
                    color: hideErrorStyle || !seeDelete
                        ? color0C0D0C
                        : colorFF6000),
              ),
            )),
        Container(
          padding: EdgeInsets.all(0),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: Colors.grey)),
          height: 40,
          child: TextFormField(
              key: widget.textFormKey,
              onChanged: (str) {
                if (widget.onChanged != null) {
                  widget.onChanged(str);
                }
                setState(() {
                  seeDelete = (str.isNotEmpty);
                  visible = seeDelete;
                  deleteHideErrorStyle = true;
                });
              },
              controller: widget.controller,
              initialValue: widget.initialValue,
              focusNode: focusNode,
              decoration: decoration,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              style: widget.style,
              textDirection: widget.textDirection,
              textAlign: widget.textAlign,
              autofocus: widget.autofocus,
              obscureText: !seeEye,
              autocorrect: widget.autocorrect,
              autovalidate: widget.autovalidate,
              maxLengthEnforced: widget.maxLengthEnforced,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              onEditingComplete: widget.onEditingComplete,
              onFieldSubmitted: widget.onFieldSubmitted,
              onSaved: widget.onSaved,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              cursorWidth: widget.cursorWidth,
              cursorRadius: widget.cursorRadius,
              cursorColor: widget.cursorColor,
              keyboardAppearance: widget.keyboardAppearance,
              scrollPadding: widget.scrollPadding,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              buildCounter: widget.buildCounter),
        ),
      ],
    );
  }
}
