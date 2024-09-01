class SearchMedicineModel {
  bool? status;
  String? message;
  int? statusNumber;
  List<MedicinesResault>? medicines;

  SearchMedicineModel(
      {this.status, this.message, this.statusNumber, this.medicines});

  SearchMedicineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusNumber = json['statusNumber'];
    if (json['medicines'] != null) {
      medicines = <MedicinesResault>[];
      json['medicines'].forEach((v) {
        medicines!.add(new MedicinesResault.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['statusNumber'] = this.statusNumber;
    if (this.medicines != null) {
      data['medicines'] = this.medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicinesResault {
  int? id;
  String? scientificName;
  String? cat;
  double? price;

  MedicinesResault({this.id, this.scientificName, this.cat, this.price});

  MedicinesResault.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scientificName = json['scientific_name'];
    cat = json['cat'];
    price = (json['price'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scientific_name'] = this.scientificName;
    data['cat'] = this.cat;
    data['price'] = this.price;
    return data;
  }
}
