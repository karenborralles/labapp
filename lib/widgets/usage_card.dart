import 'package:flutter/material.dart';
import '../../domain/entities/usage.dart';

class UsageCard extends StatelessWidget {
  final Usage usage;

  const UsageCard({super.key, required this.usage});

  @override
  Widget build(BuildContext context) {
    final bool isDeleted = usage.productName == null;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: const Icon(
          Icons.history,
          color: Color(0xFF219EBC),
          size: 40,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                usage.productName ?? 'Producto eliminado', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isDeleted ? Colors.red : Colors.black, 
                ),
              ),
            ),
            if (isDeleted)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Chip(
                  label: Text(
                    'Eliminado',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Cantidad Entregada: ${usage.quantityUsed}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Destinatario: ${usage.recipient}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Fecha: ${_formatDate(usage.usageDate)}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Formato bonito: 01/06/2025
    return '${date.day.toString().padLeft(2, '0')}/'
           '${date.month.toString().padLeft(2, '0')}/'
           '${date.year}';
  }
}