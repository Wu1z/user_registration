class LoginResponseModel {
  String? userEmail;
  String? tokenType;
  String? token;

  LoginResponseModel({this.userEmail, this.tokenType, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
    tokenType = json['tokenType'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userEmail'] = userEmail;
    data['tokenType'] = tokenType;
    data['token'] = token;
    return data;
  }
}