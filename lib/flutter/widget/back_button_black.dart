import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';

class BlackBackButton extends StatelessWidget {
  const BlackBackButton({Key key, this.color, this.onPressed}) : super(key: key);
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: const DefaultBlackBackButton(),
        color: color,
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else {
            Navigator.maybePop(context);
          }
        });
  }
}

class DefaultBlackBackButton extends StatelessWidget {

  const DefaultBlackBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => new Image.asset('assets/images/default_ic_back_black.png',package: 'habit',);
}
