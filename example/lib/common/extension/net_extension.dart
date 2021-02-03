import 'package:habit/flutter/network/entity/base_response_entity.dart';
import 'package:habit_example/generated/json/base/json_convert_content.dart';

extension NetExtension<T> on Future<BaseResponseEntity<T>> {
  Future<T> check() async {
    var baseResponseEntity = await this;
    return Future.value(JsonConvert.fromJsonAsT<T>(baseResponseEntity.data));
  }
}
