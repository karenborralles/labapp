import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class AlertCard extends StatelessWidget {
  final Product product;
  final bool isExpired;

  const AlertCard({super.key, required this.product, required this.isExpired});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Icon(
          Icons.warning_amber_rounded,
          color: isExpired ? Colors.red : Colors.orange,
          size: 40,
        ),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('Tipo: ${product.type}'),
            if (product.expiryDate != null)
              Text('Fecha de Caducidad: ${product.expiryDate!.day}/${product.expiryDate!.month}/${product.expiryDate!.year}'),
            Text(isExpired ? 'Estado: Caducado' : 'Estado: Por caducar'),
          ],
        ),
      ),
    );
  }
}