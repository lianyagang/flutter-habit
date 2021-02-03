import 'package:habit/flutter/utils/screen_utils.dart';

extension ScreenExtension on num {
  double get px => ScreenUtils.px(this);
}
