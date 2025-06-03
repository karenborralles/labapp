import '../../../domain/entities/usage.dart';

abstract class UsageState {}

class UsageInitial extends UsageState {}

class UsageLoading extends UsageState {}

class UsageLoaded extends UsageState {
  final List<Usage> usages;

  UsageLoaded(this.usages);
}

class UsageError extends UsageState {
  final String message;

  UsageError(this.message);
}