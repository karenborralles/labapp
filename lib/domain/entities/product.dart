class Product {
  final int id;
  final String name;
  final String type;
  final int quantity;
  final String unit;
  final DateTime? expiryDate;
  final DateTime entryDate;
  final bool isDeleted; 

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.quantity,
    required this.unit,
    this.expiryDate,
    required this.entryDate,
    required this.isDeleted,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      quantity: json['quantity'],
      unit: json['unit'],
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
      entryDate: DateTime.parse(json['entryDate']),
      isDeleted: json['isDeleted'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'quantity': quantity,
      'unit': unit,
      'expiryDate': expiryDate?.toIso8601String(),
      'entryDate': entryDate.toIso8601String(),
      'isDeleted': isDeleted ? 1 : 0,
    };
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}