import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/blocs/usage/usage_bloc.dart';
import '../../presentation/blocs/usage/usage_state.dart';
import '../../widgets/usage_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text('Historial de Usos'),
        backgroundColor: const Color(0xFF219EBC),
      ),
      body: BlocBuilder<UsageBloc, UsageState>(
        builder: (context, usageState) {
          if (usageState is UsageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (usageState is UsageLoaded) {
            final usages = usageState.usages;

            if (usages.isEmpty) {
              return const Center(child: Text('No hay registros de uso.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: usages.length,
              itemBuilder: (context, index) {
                final usage = usages[index];
                return UsageCard(usage: usage); 
              },
            );
          } else if (usageState is UsageError) {
            return Center(child: Text(usageState.message));
          } else {
            return const Center(child: Text('Cargando datos...'));
          }
        },
      ),
    );
  }
}