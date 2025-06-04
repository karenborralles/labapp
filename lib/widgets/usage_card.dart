import 'package:flutter/material.dart';
import '../../domain/entities/usage.dart';

class UsageCard extends StatelessWidget {
  final Usage usage;

  const UsageCard({Key? key, required this.usage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: const Icon(Icons.history, color: Color(0xFF219EBC), size: 40),
        title: Text(
          usage.productName ?? 'Producto desconocido', 
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cantidad Entregada: ${usage.quantityUsed}'),
            Text('Destinatario: ${usage.recipient}'),
            Text('Fecha: ${usage.usageDate.day}/${usage.usageDate.month}/${usage.usageDate.year}'),
          ],
        ),
      ),
    );
  }
}