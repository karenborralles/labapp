import '../../../domain/entities/product.dart';

abstract class AlertState {}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertLoaded extends AlertState {
  final List<Product> alerts;

  AlertLoaded(this.alerts);
}

class AlertError extends AlertState {
  final String message;

  AlertError(this.message);
}