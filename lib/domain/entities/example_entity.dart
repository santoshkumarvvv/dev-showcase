class ExampleEntity {
  final String id;
  final String title;
  final bool isCompleted;

  const ExampleEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  ExampleEntity copyWith({String? id, String? title, bool? isCompleted}) {
    return ExampleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
