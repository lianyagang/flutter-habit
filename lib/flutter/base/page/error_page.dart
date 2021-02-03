import 'package:flutter/material.dart';
import 'package:habit/flutter/constants/colors.dart';

class ErrorPage extends StatefulWidget {
  final String errorMessage;
  final FlutterErrorDetails details;

  ErrorPage(this.errorMessage, this.details);

  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  static List<Map<String, dynamic>> sErrorStack =
      new List<Map<String, dynamic>>();
  static List<String> sErrorName = new List<String>();

  final TextEditingController textEditingController =
      new TextEditingController();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: colorFAD6C5,
      child: new Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: new BoxDecoration(
            color: Colors.white.withAlpha(30),
            borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image(
                  image: new AssetImage("images/load_error_view.png"),
                  width: 90.0,
                  height: 90.0),
              new SizedBox(
                height: 11,
              ),
              Material(
                child: new Text(
                  "Error Occur",
                  style: new TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              new SizedBox(
                height: 40,
              ),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                      onPressed: () {
                      },
                      child: Text("Report")),
                  new SizedBox(
                    width: 40,
                  ),
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Back"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
