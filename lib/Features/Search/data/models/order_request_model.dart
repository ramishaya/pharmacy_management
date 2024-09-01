class OrderRequestModel {
  List<Product> products;

  OrderRequestModel({required this.products});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products.map((v) => v.toJson()).toList();
    return data;
  }
}

class Product {
  int? id;
  int? quantity;
  double? price;

  Product({required this.id, required this.quantity, required this.price});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
    };
  }
}
