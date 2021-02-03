
import 'package:habit_example/function/password/entity/login_req_forget_pwd_entity.dart';

loginReqForgetPwdEntityFromJson(LoginReqForgetPwdEntity data, Map<String, dynamic> json) {
	if (json['loginName'] != null) {
		data.loginName = json['loginName']?.toString();
	}
	if (json['organizeType'] != null) {
		data.organizeType = json['organizeType']?.toInt();
	}
	return data;
}

Map<String, dynamic> loginReqForgetPwdEntityToJson(LoginReqForgetPwdEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['loginName'] = entity.loginName;
	data['organizeType'] = entity.organizeType;
	return data;
}