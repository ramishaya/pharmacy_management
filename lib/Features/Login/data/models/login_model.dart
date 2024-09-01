class LoginModel {
  bool? status;
  String? message;
  int? statusNumber;
  Data? data;

  LoginModel({this.status, this.message, this.statusNumber, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusNumber'] = statusNumber;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  int? phoneNumber;
  String? password;
  String? token;

  Data({this.id, this.username, this.phoneNumber, this.password, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['token'] = token;
    return data;
  }
}
