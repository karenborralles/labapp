import '../entities/usage.dart';
import '../../data/repositories_impl/usage_repository_impl.dart';

class AddUsage {
  final UsageRepositoryImpl repository;

  AddUsage(this.repository);

  Future<void> call(Usage usage) async {
    return await repository.addUsage(usage);
  }
}
