import 'package:flutter/material.dart';
import 'package:habit/flutter/constants/colors.dart';
import 'package:habit/flutter/helper/widget_helper.dart';
import 'package:habit/flutter/utils/window_utils.dart';
import 'package:habit/flutter/widget/base_model.dart';
import 'package:habit/flutter/widget/base/base_scaffold.dart';
import 'package:habit/flutter/widget/eye_text_form_field.dart';
import 'package:habit_example/common/utils/navigator_utils.dart';
import 'package:habit_example/function/password/password_model.dart';
import 'package:habit_example/function/remark/refresh_view.dart';
import 'package:habit_example/global/global_user.dart';
import 'package:oktoast/oktoast.dart';
import 'package:habit/flutter/base/base_widget.dart';
import 'package:habit/flutter/base/base_model_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; //缓存依赖
import 'dart:convert' as Convert;

import 'password_viewmodel.dart'; //数据转化库

class PassWordForgetPage extends StatelessWidget {
  static final String sName = "/xx";

  @override
  Widget build(BuildContext context) {
    print('Rebuild');
    return BaseWidget<PassWordViewModel>(
      viewModel: PassWordViewModel(PassWordModel()),
      onModelReady: (model) => model.initialise(context),
      child: ForgetPassWordView(),
    );
  }
}

class ForgetPassWordView extends BaseModelWidget<PassWordViewModel> {
  final controllerForAccount = TextEditingController();

  @override
  Widget build(BuildContext context, PassWordViewModel model) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            padding: const EdgeInsets.all(10),
            //设置 child 居中
            alignment: Alignment.center,
            height: 80,
            width: 300,
            //边框设置
            decoration: new BoxDecoration(
              //背景
              color: Colors.grey,
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              border: new Border.all(width: 1, color: Colors.red),
            ),
            child: Text('请输入您注册时的邮箱或手机号，我们将向您发送电子邮箱或短信验证码以更改密码',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ))),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: EyeTextFormField(
              initSeeEye: true,
              onChanged: (changed) => model.setChange(changed),
              hideErrorStyle: model.hideErrorStyle,
              controller: controllerForAccount,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "邮箱/手机号",
                  hintStyle: TextStyle(
                      color: colorA4A4A4,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300)),
              maxLength: 13,
              maxLines: 1,
              buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.normal,
              )),
        ),
        Container(
          width: WindowUtils.getScreenWidth() - 20 * 2,
          height: 48.0,
          margin: const EdgeInsets.only(top: 5.0, left: 20, right: 20),
          child: RaisedButton(
            elevation: 0.0,
            color: model.enableLogin ? color_FFA22D : color_FFDAAB,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0)),
            child: Consumer<UserInfo>(
              builder: (context, user, child) {
                return Text(user.info != null ? user.info.name : "用户信息为空");
              },
            ),
            textColor: colorWhite,
            onPressed: () {
              if (model.enableLogin) {
                model.resetPassWord(context, controllerForAccount.text);
              } else {
                NavigatorUtils.goRemarkList(context, (data) {
                  // showToast("数据回调$data");
                });
                // Navigator.push(
                //         context,
                //         new MaterialPageRoute(
                //             builder: (context) => RemarkRefreshPage('ok')))
                //     .then((value) => model.reloadData());
              }
            },
          ),
        ),
      ]),
    ));
  }
}
