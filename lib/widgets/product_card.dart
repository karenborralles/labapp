import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/blocs/product/product_bloc.dart';
import '../presentation/blocs/product/product_event.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String name;
  final String type;
  final String expiry;
  final bool isNearExpiry; 

  const ProductCard({
    Key? key,
    required this.id,
    required this.name,
    required this.type,
    required this.expiry,
    this.isNearExpiry = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: isNearExpiry
            ? const BorderSide(color: Colors.redAccent, width: 2) 
            : BorderSide.none,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: const Icon(Icons.science, color: Color(0xFF219EBC), size: 40),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: $type'),
            Text('Caducidad: $expiry'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () {
            context.read<ProductBloc>().add(DeleteProductEvent(id));
          },
        ),
      ),
    );
  }
}