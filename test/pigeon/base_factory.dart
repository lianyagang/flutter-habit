import 'package:pigeon/pigeon_lib.dart';

/// flutter 输出的目录
const flutter_out_dir = "lib/pigeon/";

/// android 输出的目录
const android_out_dir = "android/src/main/java/";

/// android 包名称
const android_pck_name = "com.flutter.habit.communication";


/// 通用的配置方法
void configFactoryInfo(PigeonOptions options, String flutterFactoryFileName,
    String nativeFactoryName) {
  options.dartOut ??= flutter_out_dir + "$flutterFactoryFileName.dart";
  options.objcOptions.prefix ??= 'VV';
  options.objcHeaderOut ??= "ios/Classes/$nativeFactoryName.h";
  options.objcSourceOut ??= "ios/Classes/$nativeFactoryName.m";
  options.javaOptions.package ??= android_pck_name;
  options.javaOptions.className ??= nativeFactoryName;
  options.javaOut ??= android_out_dir +
      "${android_pck_name.replaceAll('.', '/')}/$nativeFactoryName.java";
}
