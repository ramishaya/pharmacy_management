class SignUpModel {
  bool? status;
  String? message;
  int? statusNumber;

  SignUpModel({this.status, this.message, this.statusNumber});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['statusNumber'] = statusNumber;
    return data;
  }
}