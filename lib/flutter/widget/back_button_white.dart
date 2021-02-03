import 'package:flutter/material.dart' hide Action;


class WhiteBackButton extends StatelessWidget {
  const WhiteBackButton({Key key, this.color, this.onPressed})
      : super(key: key);
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: const DefaultWhiteBackButton(),
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

class DefaultWhiteBackButton extends StatelessWidget {
  /// Creates an icon that shows the appropriate "back" image for
  /// the current platform (as obtained from the [Theme]).
  const DefaultWhiteBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      new Image.asset(
        'assets/images/default_ic_back_white.png',
        package: 'habit',
        color: Colors.white,
      );
}