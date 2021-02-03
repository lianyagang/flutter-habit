import 'package:habit/flutter/widget/base_model.dart';

import 'ForgetPassWordApiService.dart';
import 'entity/login_req_forget_pwd_entity.dart';
import 'entity/login_req_user_entity.dart';
import 'entity/login_resp_entity.dart';
import 'package:habit_example/common/extension/net_extension.dart';
class PassWordModel extends BaseModel{
  Future<LoginRespEntity> resetPassWord(LoginReqForgetPwdEntity loginReqUserEntity) =>
      apiService
          .request<LoginRespEntity>(
        ForgetPassWordApiService.FORGETURL,
        queryParameters: loginReqUserEntity.toJson(),
      ).check();
}