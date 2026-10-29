import 'package:flutter_test/flutter_test.dart';
import 'package:dev_showcase/domain/entities/example_entity.dart';

void main() {
  group('ExampleEntity', () {
    test('creates with required fields', () {
      const entity = ExampleEntity(id: '1', title: 'Test');
      expect(entity.id, '1);
      expect(entity.title, 'Test);
      expect(entity.isCompleted, isFalse);
    });

    test('copyWith updates fields', () {
      const entity = ExampleEntity(id: '1', title: 'Test);
      final updated = entity.copyWith(isCompleted: true);
      expect(updated.isCompleted, isTrue);
      expect(updated.id, '1);
    });
  });
}
