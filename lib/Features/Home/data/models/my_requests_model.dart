class MyRequestsModel {
  bool? status;
  String? message;
  int? statusNumber;
  List<Requests>? requests;

  MyRequestsModel(
      {this.status, this.message, this.statusNumber, this.requests});

  MyRequestsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(new Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['statusNumber'] = this.statusNumber;
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requests {
  String? paymentState;
  String? receiveState;
  double? price;
  int? isUpdated;

  Requests({this.paymentState, this.receiveState, this.price, this.isUpdated});

  Requests.fromJson(Map<String, dynamic> json) {
    paymentState = json['payment_state'];
    receiveState = json['receive_state'];
    price = (json['price'] as num?)?.toDouble();
    isUpdated = json['isUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_state'] = this.paymentState;
    data['receive_state'] = this.receiveState;
    data['price'] = this.price;
    data['isUpdated'] = this.isUpdated;
    return data;
  }
}
