import '../../data/repositories_impl/usage_repository_impl.dart';
import '../entities/usage.dart';

class GetUsages {
  final UsageRepositoryImpl repository;

  GetUsages(this.repository);

  Future<List<Usage>> call() {
    return repository.getUsages();
  }
}