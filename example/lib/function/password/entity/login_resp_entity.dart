

import 'package:habit_example/generated/json/base/json_convert_content.dart';

class LoginRespEntity with JsonConvert<LoginRespEntity> {
	String loginName;
	String thirdOpenId;
	String userCode;
	String organizeType;
	String thirdOpenType;
}
