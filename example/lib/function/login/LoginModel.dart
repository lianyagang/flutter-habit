import 'dart:async';

import 'package:habit/flutter/widget/base_model.dart';
import 'package:habit_example/common/extension/net_extension.dart';
import 'package:habit_example/function/password/entity/login_req_user_entity.dart';
import 'package:habit_example/function/password/entity/login_resp_entity.dart';

import 'login_service_api.dart';

class LoginModel extends BaseModel {
  Future<LoginRespEntity> login(LoginReqUserEntity loginReqUserEntity) =>
      apiService
          .request<LoginRespEntity>(
            LoginApiService.loginUrl,
            queryParameters: loginReqUserEntity.toJson(),
          )
          .check();
}
