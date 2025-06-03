class Usage {
  final int? id;
  final int productId;
  final int quantityUsed;
  final String recipient;
  final DateTime usageDate;      //  ← non-nullable
  final String? productName;

  Usage({
    this.id,
    required this.productId,
    required this.quantityUsed,
    required this.recipient,
    required this.usageDate,
    this.productName,
  });
}
