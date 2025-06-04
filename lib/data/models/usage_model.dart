import 'package:labapp/domain/entities/usage.dart';

class UsageModel {
  final int id;
  final int productId;
  final int quantityUsed;
  final String recipient;
  final DateTime usageDate;
  final String productName;

  UsageModel({
    required this.id,
    required this.productId,
    required this.quantityUsed,
    required this.recipient,
    required this.usageDate,
    required this.productName,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) {
    return UsageModel(
      id: json['id'],
      productId: json['productId'],
      quantityUsed: json['quantityUsed'],
      recipient: json['recipient'],
      usageDate: DateTime.parse(json['usageDate']),
      productName: json['product_name'],
    );
  }

  Usage toEntity() {
    return Usage(
      id: id,
      productId: productId,
      quantityUsed: quantityUsed,
      recipient: recipient,
      usageDate: usageDate,
      productName: productName,
    );
  }
}