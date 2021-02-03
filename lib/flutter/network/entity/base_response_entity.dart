/// data : "T"
/// code : 10000
/// msg : "msg"
/// timeStamp : "timeStamp"

class BaseResponseEntity<T> {
  dynamic data;
  int code;
  String msg;
  num timeStamp;

  BaseResponseEntity({this.data, this.code, this.msg, this.timeStamp});

  BaseResponseEntity.fromJson(dynamic json) {
    data = json["data"];
    code = json["code"];
    msg = json["msg"];
    timeStamp = json["timeStamp"];
  }

  bool isResponse() {
    return code == 10000;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["data"] = data;
    map["code"] = code;
    map["msg"] = msg;
    map["timeStamp"] = timeStamp;
    return map;
  }
}
