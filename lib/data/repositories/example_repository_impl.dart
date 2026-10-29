import 'package:dev_showcase/domain/entities/example_entity.dart';
import 'package:dev_showcase/domain/repositories/example_repository.dart';

class ExampleRepositoryImpl implements ExampleRepository {
  // TODO: inject data source (API / local DB)
  @override
  Future<List<ExampleEntity>> getExamples() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return const [
      ExampleEntity(id: '1', title: 'Learn Clean Architecture'),
      ExampleEntity(id: '2', title: 'Ship CI/CD pipeline', isCompleted: true),
    ];
  }

  @override
  Future<ExampleEntity> getExampleById(String id) async {
    final items = await getExamples();
    return items.firstWhere((e) => e.id == id);
  }

  @override
  Future<void> saveExample(ExampleEntity entity) async {
    // TODO: persist to local DB or API
  }
}
