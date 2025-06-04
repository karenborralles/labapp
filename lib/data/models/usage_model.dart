import '../../domain/entities/usage.dart';

class UsageModel extends Usage {
  UsageModel({
    int? id,
    required int productId,
    required int quantityUsed,
    required String recipient,
    required DateTime usageDate,
    String? productName,
  }) : super(
          id: id,
          productId: productId,
          quantityUsed: quantityUsed,
          recipient: recipient,
          usageDate: usageDate,
          productName: productName,
        );

  factory UsageModel.fromJson(Map<String, dynamic> json) => UsageModel(
        id          : json['id'],
        productId   : json['productId'],
        quantityUsed: json['quantityUsed'],
        recipient   : json['recipient'],
        usageDate   : DateTime.parse(json['usageDate']),
        productName : json['productName'],   // 👈 CAMBIA ESTO
      );
}