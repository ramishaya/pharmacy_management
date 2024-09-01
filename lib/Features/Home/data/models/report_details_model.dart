class ReportDetailsModel {
  bool? status;
  String? message;
  int? statusNumber;
  List<ReportDetails>? details;

  ReportDetailsModel(
      {this.status, this.message, this.statusNumber, this.details});

  ReportDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    if (json['details'] != null) {
      details = <ReportDetails>[];
      json['details'].forEach((v) {
        details!.add(new ReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['statusNumber'] = this.statusNumber;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportDetails {
  int? id;
  String? scientificName;
  String? commercialName;
  String? cat;
  String? manufacturer;
  String? expireDate;
  double? price;

  ReportDetails(
      {this.id,
      this.scientificName,
      this.commercialName,
      this.cat,
      this.manufacturer,
      this.expireDate,
      this.price});

  ReportDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scientificName = json['scientific_name'];
    commercialName = json['commercial_name'];
    cat = json['cat'];
    manufacturer = json['manufacturer'];
    expireDate = json['expire_date'];
    price = (json['price'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scientific_name'] = this.scientificName;
    data['commercial_name'] = this.commercialName;
    data['cat'] = this.cat;
    data['manufacturer'] = this.manufacturer;
    data['expire_date'] = this.expireDate;
    data['price'] = this.price;
    return data;
  }
}
