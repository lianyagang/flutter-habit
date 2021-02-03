
import 'package:habit_example/function/password/entity/login_resp_entity.dart';

loginRespEntityFromJson(LoginRespEntity data, Map<String, dynamic> json) {
	if (json['loginName'] != null) {
		data.loginName = json['loginName']?.toString();
	}
	if (json['thirdOpenId'] != null) {
		data.thirdOpenId = json['thirdOpenId']?.toString();
	}
	if (json['userCode'] != null) {
		data.userCode = json['userCode']?.toString();
	}
	if (json['organizeType'] != null) {
		data.organizeType = json['organizeType']?.toString();
	}
	if (json['thirdOpenType'] != null) {
		data.thirdOpenType = json['thirdOpenType']?.toString();
	}
	return data;
}

Map<String, dynamic> loginRespEntityToJson(LoginRespEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['loginName'] = entity.loginName;
	data['thirdOpenId'] = entity.thirdOpenId;
	data['userCode'] = entity.userCode;
	data['organizeType'] = entity.organizeType;
	data['thirdOpenType'] = entity.thirdOpenType;
	return data;
}