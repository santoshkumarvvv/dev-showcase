import 'package:dev_showcase/domain/entities/example_entity.dart';

abstract class ExampleRepository {
  Future<List<ExampleEntity>> getExamples();
  Future<ExampleEntity> getExampleById(String id);
  Future<void> saveExample(ExampleEntity entity);
}
