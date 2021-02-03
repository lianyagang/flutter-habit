

import 'package:habit_example/generated/json/base/json_convert_content.dart';

class RemarkRespListEntity with JsonConvert<RemarkRespListEntity> {
	String img;
	String title;

	RemarkRespListEntity(this.img, this.title);
}
