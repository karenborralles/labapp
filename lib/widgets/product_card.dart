import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/blocs/product/product_bloc.dart';
import '../presentation/blocs/product/product_event.dart';
import '../presentation/blocs/alert/alert_bloc.dart';        
import '../presentation/blocs/alert/alert_event.dart';       

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                context.read<ProductBloc>().add(DeleteProductEvent(id));
                context.read<AlertBloc>().add(LoadAlertsEvent());  
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF219EBC)),
              onPressed: () {
                final _quantityController = TextEditingController();

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Actualizar Cantidad'),
                    content: TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nueva cantidad',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newQuantity = int.tryParse(_quantityController.text);
                          if (newQuantity != null) {
                            context.read<ProductBloc>().add(UpdateProductEvent(id, newQuantity));
                            context.read<AlertBloc>().add(LoadAlertsEvent()); 
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}