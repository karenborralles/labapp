import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:labapp/presentation/blocs/product/product_bloc.dart';
import 'package:labapp/presentation/blocs/product/product_event.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? selectedType;
  String? selectedUnit;
  DateTime? entryDate;
  DateTime? expiryDate;

  final List<String> productTypes = [
    'Reactivo',
    'Material',
    'Instrumento',
    'Consumible',
  ];

  final List<String> units = [
    'Litros',
    'Mililitros',
    'Gramos',
    'Kilogramos',
    'Piezas',
  ];

  Future<void> _selectDate(BuildContext context, bool isEntryDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isEntryDate) {
          entryDate = picked;
        } else {
          expiryDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _saveProduct() async {
    final name = _nameController.text.trim();
    final quantity = _quantityController.text.trim();
    final type = selectedType;
    final unit = selectedUnit;
    final entry = entryDate?.toIso8601String();
    final expiry = expiryDate?.toIso8601String();

    if (name.isEmpty || quantity.isEmpty || type == null || unit == null || entry == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos obligatorios')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.79:3000/api/products'), 
        headers: {'Content-Type': 'application/json'},
        body: '''
          {
            "name": "$name",
            "type": "$type",
            "quantity": $quantity,
            "unit": "$unit",
            "entryDate": "$entry",
            "expiryDate": ${expiry != null ? '"$expiry"' : 'null'}
          }
        ''',
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto guardado exitosamente')),
        );

        context.read<ProductBloc>().add(LoadProductsEvent());

        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/');
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode} al guardar')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar con el servidor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Agregar Producto'),
        backgroundColor: const Color(0xFF219EBC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text('Nombre del producto:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: Ácido sulfúrico',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tipo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              hint: const Text('Selecciona un tipo'),
              value: selectedType,
              items: productTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Cantidad:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Cantidad numérica',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Unidad de medida:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: UnderlineInputBorder()),
              hint: const Text('Selecciona una unidad'),
              value: selectedUnit,
              items: units.map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUnit = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Fecha de ingreso:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: _formatDate(entryDate) == '' ? 'Selecciona una fecha' : _formatDate(entryDate),
                    border: const UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Fecha de caducidad (opcional):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: _formatDate(expiryDate) == '' ? 'Selecciona una fecha' : _formatDate(expiryDate),
                    border: const UnderlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF219EBC), width: 2),
                ),
                onPressed: _saveProduct,
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Color(0xFF219EBC),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}