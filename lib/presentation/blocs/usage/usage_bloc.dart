import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_usage.dart';
import '../../../data/repositories_impl/usage_repository_impl.dart';
import 'usage_event.dart';
import 'usage_state.dart';

class UsageBloc extends Bloc<UsageEvent, UsageState> {
  final AddUsage addUsage;
  final UsageRepositoryImpl usageRepository;

  UsageBloc(this.addUsage, this.usageRepository) : super(UsageInitial()) {
    on<LoadUsagesEvent>((event, emit) async {
      emit(UsageLoading());
      try {
        final usages = await usageRepository.getUsages();
        emit(UsageLoaded(usages));
      } catch (e) {
        emit(UsageError('Error al cargar historial de usos'));
      }
    });

    on<AddUsageEvent>((event, emit) async {
      try {
        await addUsage(event.usage);
        final usages = await usageRepository.getUsages();
        emit(UsageLoaded(usages));
      } catch (e) {
        emit(UsageError('Error al registrar uso'));
      }
    });
  }
}