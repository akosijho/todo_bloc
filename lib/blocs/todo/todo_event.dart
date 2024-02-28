part of 'todo_bloc.dart';
abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTodo extends TodoEvent{
  final Todo todo;

  AddTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class LoadTodoEvent extends TodoEvent{
  final List<Todo> todos;

  LoadTodoEvent({this.todos = const <Todo>[]});

  @override
  List<Object?> get props => [todos];
}

class UpdateTodo extends TodoEvent{
  final Todo todo;

  UpdateTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class DeleteTodo extends TodoEvent{
  final Todo todo;

  DeleteTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}
