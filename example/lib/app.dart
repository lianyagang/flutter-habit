import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_example/function/login/login_view.dart';
import 'package:habit_example/function/password/password_view.dart';
import 'package:habit_example/function/remark/refresh_view.dart';
import 'package:habit_example/view_model_example.dart';
import 'package:oktoast/oktoast.dart';
import 'package:habit/flutter/utils/sp_utils/sp_utils.dart';
import 'common/localization/gsy_localizations_delegate.dart';
import 'global/global_user.dart';

class FlutterLifeApp extends StatefulWidget {
  @override
  _FlutterLifeAppState createState() => _FlutterLifeAppState();
}

class _FlutterLifeAppState extends State<FlutterLifeApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SpUtils().init(); //初始化 sp
    return OKToast(
      child: new MaterialApp(
        ///多语言实现代理
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GSYLocalizationsDelegate.delegate,
        ],

        ///命名式路由
        /// "/" 和 MaterialApp 的 home 参数一个效果
        routes: {
          PassWordForgetPage.sName: (context) {
            return PassWordForgetPage();
          },
          RemarkRefreshPage.sName: (context) {
            return RemarkRefreshPage("1111");
          },
          LoginViewPage.sName: (context) {
            //return LoginViewPage();
            return ViewModelExample();
          }
        },
      ),
    );
  }
}
