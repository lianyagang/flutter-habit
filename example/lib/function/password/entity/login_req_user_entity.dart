
import 'package:habit_example/generated/json/base/json_convert_content.dart';

class LoginReqUserEntity with JsonConvert<LoginReqUserEntity> {
	String loginName;
	String password;
	int organizeType;
}
