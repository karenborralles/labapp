import '../../../domain/entities/usage.dart';

abstract class UsageEvent {}

class LoadUsagesEvent extends UsageEvent {}

class AddUsageEvent extends UsageEvent {
  final Usage usage;

  AddUsageEvent(this.usage);
}