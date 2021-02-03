import 'package:habit/habit.dart';

class RepeatValueNotifier<T> extends ValueNotifier<T> {
  RepeatValueNotifier(value) : super(value);

  /// 更改值，强制刷新
  void notifyChange([T t]) {
    if (t != null && value != t) {
      value = t;
    } else {
      notifyListeners();
    }
  }
}
