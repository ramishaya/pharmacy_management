class MedicineDetailsModel {
  bool? status;
  String? message;
  int? statusNumber;
  Details? details;

  MedicineDetailsModel(
      {this.status, this.message, this.statusNumber, this.details});

  MedicineDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['statusNumber'] = this.statusNumber;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  int? id;
  String? scientificName;
  String? commercialName;
  String? cat;
  String? manufacturer;
  int? quantity;
  String? expireDate;
  double? price;

  Details(
      {this.id,
      this.scientificName,
      this.commercialName,
      this.cat,
      this.manufacturer,
      this.quantity,
      this.expireDate,
      this.price});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scientificName = json['scientific_name'];
    commercialName = json['commercial_name'];
    cat = json['cat'];
    manufacturer = json['manufacturer'];
    quantity = json['quantity'];
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
    data['quantity'] = this.quantity;
    data['expire_date'] = this.expireDate;
    data['price'] = this.price;
    return data;
  }
}
