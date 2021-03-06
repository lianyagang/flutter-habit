// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:habit_example/function/password/entity/login_req_forget_pwd_entity.dart';
import 'package:habit_example/function/password/entity/login_req_user_entity.dart';
import 'package:habit_example/function/password/entity/login_resp_entity.dart';
import 'package:habit_example/function/remark/entity/remark_resp_list_entity.dart';
import 'package:habit_example/generated/json/login_req_forgetpwd_entity_helper.dart';
import 'package:habit_example/generated/json/login_resp_entity_helper.dart';
import 'package:habit_example/generated/json/login_req_user_entity_helper.dart';
import 'package:habit_example/generated/json/remark_resp_list_entity_helper.dart';

class JsonConvert<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
      case RemarkRespListEntity:
        return remarkRespListEntityFromJson(data as RemarkRespListEntity, json) as T;
      case LoginReqForgetPwdEntity:
        return loginReqForgetPwdEntityFromJson(
            data as LoginReqForgetPwdEntity, json) as T;
      case LoginRespEntity:
        return loginRespEntityFromJson(data as LoginRespEntity, json) as T;
      case LoginReqUserEntity:
        return loginReqUserEntityFromJson(data as LoginReqUserEntity, json)
            as T;
    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
    switch (type) {
      case RemarkRespListEntity:
        return remarkRespListEntityToJson(data as RemarkRespListEntity);
      case LoginReqForgetPwdEntity:
        return loginReqForgetPwdEntityToJson(data as LoginReqForgetPwdEntity);
      case LoginRespEntity:
        return loginRespEntityToJson(data as LoginRespEntity);
      case LoginReqUserEntity:
        return loginReqUserEntityToJson(data as LoginReqUserEntity);
    }
    return data as T;
  }

  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
      case 'LoginRespEntity':
        return LoginRespEntity().fromJson(json);
      case 'LoginReqUserEntity':
        return LoginReqUserEntity().fromJson(json);
      case 'LoginReqForgetPwdEntity':
        return LoginReqForgetPwdEntity().fromJson(json);
    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      case 'LoginRespEntity':
        return List<LoginRespEntity>();
      case 'LoginReqUserEntity':
        return List<LoginReqUserEntity>();
      case 'LoginReqForgetPwdEntity':
        return List<LoginReqForgetPwdEntity>();
    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
