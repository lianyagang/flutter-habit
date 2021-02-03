import 'package:habit/flutter/network/entity/base_request_entity.dart';

baseRequestEntityFromJson(BaseRequestEntity data, Map<String, dynamic> json) {
	if (json['params'] != null) {
		data.params = json['params']?.toString();
	}
	if (json['sign'] != null) {
		data.sign = json['sign']?.toString();
	}
	if (json['timeStamp'] != null) {
		data.timeStamp = json['timeStamp']?.toString();
	}
	return data;
}

Map<String, dynamic> baseRequestEntityToJson(BaseRequestEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['params'] = entity.params;
	data['sign'] = entity.sign;
	data['timeStamp'] = entity.timeStamp;
	return data;
}