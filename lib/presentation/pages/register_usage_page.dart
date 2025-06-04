import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/blocs/usage/usage_bloc.dart';
import '../../presentation/blocs/usage/usage_event.dart';
import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/product/product_state.dart';
import '../../domain/entities/usage.dart';
import '../../domain/entities/product.dart';
import '../../presentation/blocs/product/product_event.dart';

class RegisterUsagePage extends StatefulWidget {
  const RegisterUsagePage({super.key});

  @override
  State<RegisterUsagePage> createState() => _RegisterUsagePageState();
}

class _RegisterUsagePageState extends State<RegisterUsagePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  DateTime? _selectedDate;

  Product? _selectedProduct;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent()); 
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _registerUsage() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedProduct != null) {
      final usage = Usage(
        id: 0,
        productId: _selectedProduct!.id, 
        quantityUsed: int.parse(_quantityController.text),
        recipient: _recipientController.text,
        usageDate: _selectedDate!,
      );

      context.read<UsageBloc>().add(AddUsageEvent(usage));

      if (context.canPop()) {
        context.pop(); 
      } else {
        context.go('/'); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
        title: const Text('Registrar Uso'),
        backgroundColor: const Color(0xFF219EBC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final products = state.products;

              return Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text('Producto:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<Product>(
                      value: _selectedProduct,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Selecciona un producto',
                      ),
                      items: products.map((product) {
                        return DropdownMenuItem<Product>(
                          value: product,
                          child: Text('${product.name} (${product.unit})'),
                        );
                      }).toList(),
                      onChanged: (Product? newValue) {
                        setState(() {
                          _selectedProduct = newValue;
                        });
                      },
                      validator: (value) => value == null ? 'Por favor selecciona un producto' : null,
                    ),
                    const SizedBox(height: 20),
                    const Text('Cantidad a entregar:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: _selectedProduct != null ? 'Cantidad en ${_selectedProduct!.unit}' : 'Cantidad',
                        border: const UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa la cantidad';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Destinatario (Grupo o Estudiante):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(
                        hintText: 'Ejemplo: Grupo 3°B',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un destinatario';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Fecha de entrega:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: _selectedDate == null
                                ? 'Selecciona una fecha'
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (_) {
                            if (_selectedDate == null) {
                              return 'Por favor selecciona una fecha';
                            }
                            return null;
                          },
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
                        onPressed: _registerUsage,
                        child: const Text(
                          'Registrar Uso',
                          style: TextStyle(
                            color: Color(0xFF219EBC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Error cargando productos'));
            }
          },
        ),
      ),
    );
  }
}