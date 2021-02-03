import 'package:flutter/widgets.dart';
import 'package:habit/flutter/utils/screen_utils.dart';


class ScreenUtilInit extends StatelessWidget {
  /// A helper widget that initializes [ScreenUtil]
  ScreenUtilInit({
    @required this.child,
    this.designSize = 375,
    Key key,
  }) : super(key: key);

  final Widget child;

  /// 默认设计稿尺寸
  final int designSize;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // ignore: missing_return
        builder: (_, BoxConstraints constraints) {
          if (constraints.maxWidth != 0) {
            ScreenUtils.init(constraints, designSize);
            return child;
          }
        }
    );
  }
}
