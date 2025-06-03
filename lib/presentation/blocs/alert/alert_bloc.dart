import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_alerts.dart';
import 'alert_event.dart';
import 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final GetAlerts getAlerts;

  AlertBloc(this.getAlerts) : super(AlertInitial()) {
    on<LoadAlertsEvent>((event, emit) async {
      emit(AlertLoading());
      try {
        final alerts = await getAlerts();
        emit(AlertLoaded(alerts));
      } catch (e) {
        emit(AlertError('Error al cargar alertas'));
      }
    });
  }
}