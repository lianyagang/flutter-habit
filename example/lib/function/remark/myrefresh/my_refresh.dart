import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LifeRefresh extends StatefulWidget {
  LifeRefresh({
    Key key,
  }) : super(key: key);

  @override
  _LifeRefreshState createState() {
    // TODO: implement createState
    return _LifeRefreshState();
  }
}

class _LifeRefreshState extends State<LifeRefresh> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom();
  }
}
