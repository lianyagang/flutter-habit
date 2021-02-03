import 'package:flutter/material.dart' hide Action;
import 'package:habit/flutter/widget/back_button_black.dart';

import 'Toolbar.dart';

class WebViewToolbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isH5App;

  const WebViewToolbar({Key key, this.title, this.isH5App}) : super(key: key);

  @override
  WebViewToolbarState createState() => WebViewToolbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class WebViewToolbarState extends State<WebViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Toolbar(
            automaticallyImplyLeading: false,
            title: new Text(widget.title),
            centerTitle: true,
            leading: null),
        SafeArea(
          top: true,
          child: Center(
            child: Row(
              children: <Widget>[
                const BlackBackButton(),
                widget.isH5App != null && widget.isH5App
                    ? null
                    : IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
              ].where((obj) => obj != null).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
