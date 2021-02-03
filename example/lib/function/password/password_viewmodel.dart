import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/base/property/empty_state_model.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:habit_example/function/password/password_model.dart';
import 'package:oktoast/oktoast.dart';

import 'entity/login_req_forget_pwd_entity.dart';
import 'entity/login_req_user_entity.dart';

class PassWordViewModel extends BaseViewModel<PassWordModel> {
  String title = 'default';
  bool hideErrorStyle = true;
  bool enableLogin = false;

  PassWordViewModel(PassWordModel model) : super(model);

  void initialise(BuildContext context) {
    title = 'initialised';
    notifyListeners();
    // String data = '{"name":"测试信息64664","accessToken":"123","mobile":"456"}';
    // Map<String, dynamic> userInfo = Convert.jsonDecode(data);//转化数据，我自己写的用户数据是标准的JSON，但是还是需要toString之后在jsonDecode
    // Provider.of<UserInfo>(context, listen: true).setInfo(userInfo);
  }

  int counter = 0;

  void updateTitle() {
    counter++;
    title = '$counter';
    notifyListeners();
  }

  void reloadData(String data) {
    Future.delayed(Duration(seconds: 3), () {});
  }

  ///邮箱验证
  bool isEmail(String str) {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  Future<void> resetPassWord(BuildContext context, String text) async {
    if (isEmail(text)) {
      launch(() async {
        var loginForgetReq = LoginReqForgetPwdEntity()
          ..loginName = 'lianyagang@vv.cn'
          ..organizeType = '3';

        var login = await model.resetPassWord(loginForgetReq);
        showToast(login.loginName);
      }, (err) {
      });
    } else {

      hideErrorStyle = false;
      notifyListeners();
    }
  }

  setChange(String changed) {
    if (changed.isNotEmpty) {
      enableLogin = true;
      notifyListeners();
    } else {
      enableLogin = false;
      notifyListeners();
    }
  }
}
