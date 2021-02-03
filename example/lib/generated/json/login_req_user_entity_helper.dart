
import 'package:habit_example/function/password/entity/login_req_user_entity.dart';

loginReqUserEntityFromJson(LoginReqUserEntity data, Map<String, dynamic> json) {
	if (json['loginName'] != null) {
		data.loginName = json['loginName']?.toString();
	}
	if (json['password'] != null) {
		data.password = json['password']?.toString();
	}
	if (json['organizeType'] != null) {
		data.organizeType = json['organizeType']?.toInt();
	}
	return data;
}

Map<String, dynamic> loginReqUserEntityToJson(LoginReqUserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['loginName'] = entity.loginName;
	data['password'] = entity.password;
	data['organizeType'] = entity.organizeType;
	return data;
}