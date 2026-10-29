import 'package:dev_showcase/domain/entities/example_entity.dart';

class ExampleModel extends ExampleEntity {
  const ExampleModel({
    required super.id,
    required super.title,
    super.isCompleted,
  });

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    return ExampleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };
}
