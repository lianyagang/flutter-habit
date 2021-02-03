import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class EncryptUtil {

  static final String API_KEY = "这里填写跟服务端约定的key";
  static final String API_SECRET = "这里填写跟服务端约定的SECRET";

  //aes加密
  static String aesEncode(String content) {
    try {
      final key = Key.fromUtf8(API_SECRET); //加密key
      final iv = IV.fromUtf8(API_SECRET); //偏移量
      //设置cbc模式
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(content, iv: iv);
      var base64 = encrypted.base64;
      print("加密:$base64");
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      print("解密:$decrypted");
      return base64;
    } catch (err) {
      print("aes encode error:$err");
      return content;
    }
  }

  //aes解密
  static String aesDecode(String base64) {
    try {
      final key = Key.fromUtf8(API_SECRET); //加密key
      final iv = IV.fromUtf8(API_SECRET); //偏移量
      //设置cbc模式
      final encrypt = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
      String decry64 = encrypt.decrypt64(base64,
          iv: iv);
      return decode(decry64);
    } catch (err) {
      print("aes decode error:$err");
      return base64;
    }
  }

  static decode(String decry64) {
    var decryptedData = Utf8Encoder().convert(decry64);

    int pad = decryptedData[decryptedData.length - 1];
    if (pad < 1 || pad > 32) {
      pad = 0;
    }
    if (pad > 0) {
      var inputAsUint8List = decryptedData.sublist(0, decryptedData.length - pad);
      return Utf8Decoder().convert(inputAsUint8List);
    }
    return decry64;
  }

  static String getSign(String timeStamp, String params) {
    var content = new Utf8Encoder().convert(timeStamp + API_KEY + params);
    var digest = md5.convert(content).toString().toUpperCase();
    return digest;
  }

  static String currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch.toString();
  }
}
