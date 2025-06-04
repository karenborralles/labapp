import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/product/product_bloc.dart';
import '../../presentation/blocs/product/product_state.dart';
import '../../presentation/blocs/product/product_event.dart';
import '../../widgets/product_card.dart';
import '../../data/datasources/auth_local_datasource.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  Future<void> _navigateToAddProduct(BuildContext context) async {
    await context.push('/add-product');
    _loadProducts(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Inventario de Laboratorio'),
        backgroundColor: const Color(0xFF219EBC),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final products = List.of(state.products); 

            if (products.isEmpty) {
              return const Center(child: Text('No hay productos disponibles.'));
            }

            products.sort((a, b) {
              if (a.expiryDate == null && b.expiryDate == null) return 0;
              if (a.expiryDate == null) return 1;
              if (b.expiryDate == null) return -1;
              return a.expiryDate!.compareTo(b.expiryDate!);
            });

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                // Detectar si el producto va a caducar pronto (en 10 días o menos)
                final bool isNearExpiry = product.expiryDate != null &&
                    product.expiryDate!.isBefore(DateTime.now().add(const Duration(days: 10)));

                return ProductCard(
                  id: product.id,
                  name: product.name,
                  type: product.type,
                  expiry: product.expiryDate != null
                      ? '${product.expiryDate!.day}/${product.expiryDate!.month}/${product.expiryDate!.year}'
                      : 'Sin caducidad',
                  isNearExpiry: isNearExpiry,
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Cargando productos...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF219EBC),
        child: const Icon(Icons.add),
        onPressed: () => _navigateToAddProduct(context),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE5E5E5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF219EBC),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.science, color: Colors.white, size: 60),
                  SizedBox(height: 10),
                  Text(
                    'LabTrack',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment_outlined),
            title: const Text('Registrar Uso'),
            onTap: () {
              Navigator.pop(context); 
              context.push('/register-usage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historial'),
            onTap: () {
              Navigator.pop(context);
              context.push('/history'); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('Alertas'),
            onTap: () {
              Navigator.pop(context);
              context.push('/alerts'); 
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () async {
              await AuthLocalDataSource().deleteToken(); 
              Navigator.pop(context);
              context.go('/login'); 
            },
          ),
        ],
      ),
    );
  }
}