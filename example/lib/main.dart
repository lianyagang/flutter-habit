import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit/flutter/base/page/error_page.dart';
import 'package:habit/flutter/utils/platform_utils.dart';
import 'package:habit_example/global/global_user.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'env/config_wrapper.dart';
import 'env/dev.dart';
import 'env/env_config.dart';
import 'global/LoginProvider.dart';

void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return ErrorPage(
          details.exception.toString() + "\n " + details.stack.toString(),
          details);
    };

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => new UserInfo()),
        ChangeNotifierProvider(create: (context) => new LoginProvider()),
      ],
      child: FlutterLifeApp(),
    ));
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}
