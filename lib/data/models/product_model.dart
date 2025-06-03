import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String type,
    required int quantity,
    required String unit,
    required DateTime entryDate,
    required bool isDeleted,
    DateTime? expiryDate,
  }) : super(
          id: id,
          name: name,
          type: type,
          quantity: quantity,
          unit: unit,
          entryDate: entryDate,
          isDeleted: isDeleted, 
          expiryDate: expiryDate,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      quantity: json['quantity'],
      unit: json['unit'],
      entryDate: DateTime.parse(json['entryDate']),
      isDeleted: json['isDeleted'] == 1, 
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'quantity': quantity,
      'unit': unit,
      'entryDate': entryDate.toIso8601String(),
      'isDeleted': isDeleted ? 1 : 0, 
      'expiryDate': expiryDate?.toIso8601String(),
    };
  }
}