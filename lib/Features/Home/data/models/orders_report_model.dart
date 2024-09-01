class OrdersReportModel {
  bool? status;
  String? message;
  int? statusNumber;
  List<MyOrdersReport>? requests;

  OrdersReportModel(
      {this.status, this.message, this.statusNumber, this.requests});

  OrdersReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    if (json['requests'] != null) {
      requests = <MyOrdersReport>[];
      json['requests'].forEach((v) {
        requests!.add(new MyOrdersReport.fromJson(v));
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

class MyOrdersReport {
  int? id;
  int? pharId;
  String? paymentState;
  String? receiveState;
  double? price;

  MyOrdersReport(
      {this.id, this.pharId, this.paymentState, this.receiveState, this.price });

  MyOrdersReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharId = json['phar_id'];
    paymentState = json['payment_state'];
    receiveState = json['receive_state'];
    //price = json['price'] != null ? (json['price'] is int ? (json['price'] as int).toDouble() : json['price'].toDouble()) : null;
        price = (json['price'] as num?)?.toDouble();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phar_id'] = this.pharId;
    data['payment_state'] = this.paymentState;
    data['receive_state'] = this.receiveState;
    //data['price'] = this.price;
    return data;
  }
}
