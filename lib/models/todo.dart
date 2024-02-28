import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo(
      {required this.id,
      required this.name,
      required this.description,
      this.severity = Severity.low,
      this.completed = false});

  final String id;
  final String name;
  final String description;
  final Severity severity;
  final bool completed;

  Todo copyWith(
      {String? id, String? name, String? description, bool? completed,
      Severity? severity}) {
    return Todo(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        severity: severity ?? this.severity,
        completed: completed ?? this.completed);
  }

  @override
  List<Object?> get props => [id, name, description, completed, severity];
}

enum Severity { low, medium, high }
enum TodoFilter {all, completed, pending}
