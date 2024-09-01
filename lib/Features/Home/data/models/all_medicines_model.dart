import 'dart:convert';


class AllMedicinesModel {
  final bool status;
  final String message;
  final int statusNumber;
  final Medicines medicines;

  AllMedicinesModel({
    required this.status,
    required this.message,
    required this.statusNumber,
    required this.medicines,
  });

  factory AllMedicinesModel.fromJson(Map<String, dynamic> json) => AllMedicinesModel(
        status: json['status'],
        message: json['message'],
        statusNumber: json['statusNumber'],
        medicines: Medicines.fromJson(json['medicines']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'statusNumber': statusNumber,
        'medicines': medicines.toJson(),
      };
}

// Medicines class updated for dynamic categories
class Medicines {
  Map<String, List<Medicine>> categories = {};

  Medicines({required this.categories});

  factory Medicines.fromJson(Map<String, dynamic> json) {
    Map<String, List<Medicine>> categoriesMap = {};
    json.forEach((key, value) {
      categoriesMap[key] = List<Medicine>.from(value.map((x) => Medicine.fromJson(x)));
    });
    return Medicines(categories: categoriesMap);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    categories.forEach((key, value) {
      json[key] = List<dynamic>.from(value.map((x) => x.toJson()));
    });
    return json;
  }

  // Function to get medicines by category name
  List<Medicine> getMedicinesByCategory(String category) {
    return categories[category] ?? [];
  }

  // Function to add a new category or medicine to an existing category
  void addMedicine(String category, Medicine medicine) {
    if (!categories.containsKey(category)) {
      categories[category] = [];
    }
    categories[category]?.add(medicine);
  }
}

// Medicine class
class Medicine {
  final String scientificName;
  final String commercialName;
  final String category;
  final String manufacturer;
  final int quantity;
  final DateTime expireDate;
  final double price;

  Medicine({
    required this.scientificName,
    required this.commercialName,
    required this.category,
    required this.manufacturer,
    required this.quantity,
    required this.expireDate,
    required this.price,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        scientificName: json['scientific_name'],
        commercialName: json['commercial_name'],
        category: json['cat'],
        manufacturer: json['manufacturer'],
        quantity: json['quantity'],
        expireDate: DateTime.parse(json['expire_date']),
        price: json['price'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'scientific_name': scientificName,
        'commercial_name': commercialName,
        'cat': category,
        'manufacturer': manufacturer,
        'quantity': quantity,
        'expire_date': "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
        'price': price,
      };
}

// Function to convert your JSON into the model
AllMedicinesModel parseResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return AllMedicinesModel.fromJson(parsed);
}
