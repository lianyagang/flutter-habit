import 'dart:convert' as Convert; //数据转化库

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/flutter/base/property/empty_state_model.dart';
import 'package:habit/flutter/utils/sp_utils/sp_constant.dart';
import 'package:habit/flutter/utils/sp_utils/sp_utils.dart';
import 'package:habit/flutter/widget/base_view_model.dart';
import 'package:habit_example/common/localization/default_localizations.dart';
import 'package:habit_example/common/utils/navigator_utils.dart';
import 'package:habit_example/function/password/entity/login_req_user_entity.dart';
import 'package:habit_example/function/password/password_view.dart';
import 'package:habit_example/global/global_user.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'LoginModel.dart';

class LoginViewModel extends BaseViewModel<LoginModel> {
  bool hideErrorStyle = true;
  bool enableLogin = true;

  LoginViewModel(LoginModel model) : super(model);

  initialise(BuildContext _context) {
    setAppBarTitle(GSYLocalizations.i18n(_context).app_name);
  }

  getUserInfo(BuildContext _context) {
    var authorization = SpUtils.getString(SpConstants.authorization);
    var mapUserInfo =
        Convert.jsonDecode(authorization); //转化成Map<String Dynamic>类型
    Provider.of<UserInfo>(_context, listen: true).setInfo(mapUserInfo);
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

  void toLogin(BuildContext context, String account, String password) {
    var loginReqUserEntity = LoginReqUserEntity()
      ..loginName = "lianyagang@vv.cn"
      ..password = "Admin12311"
      ..organizeType = 3;
    launch(() async {
      var login = await model.login(loginReqUserEntity);
      showToast(login.loginName);
      NavigatorUtils.pushNamed(context, PassWordForgetPage.sName);
    }, (err) {
    });
  }

  @override
  void onReloadData() {
    // TODO: implement onReloadData
    super.onReloadData();
    showToast('登录错误');
  }
}
