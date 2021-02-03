

import 'package:habit_example/function/remark/entity/remark_resp_list_entity.dart';

remarkRespListEntityFromJson(RemarkRespListEntity data, Map<String, dynamic> json) {
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['img'] != null) {
		data.img = json['img']?.toString();
	}

	return data;
}

Map<String, dynamic> remarkRespListEntityToJson(RemarkRespListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['title'] = entity.title;
	data['img'] = entity.img;
	return data;
}