class UserModel {
  String name;
  String accessToken;
  String mobile;

  UserModel({this.name, this.accessToken, this.mobile});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accessToken = json['access_token'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['access_token'] = this.accessToken;
    data['mobile'] = this.mobile;
    return data;
  }
}