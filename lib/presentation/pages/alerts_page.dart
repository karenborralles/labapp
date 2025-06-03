import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/alert/alert_bloc.dart';
import '../../presentation/blocs/alert/alert_state.dart';
import '../../widgets/alert_card.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Alertas de Caducidad'),
        backgroundColor: const Color(0xFF219EBC),
      ),
      body: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          if (state is AlertLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlertLoaded) {
            final alerts = state.alerts;
            if (alerts.isEmpty) {
              return const Center(child: Text('No hay productos por caducar.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final product = alerts[index];
                final isExpired = product.expiryDate != null && product.expiryDate!.isBefore(DateTime.now());

                return AlertCard(product: product, isExpired: isExpired);
              },
            );
          } else if (state is AlertError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Cargando alertas...'));
          }
        },
      ),
    );
  }
}