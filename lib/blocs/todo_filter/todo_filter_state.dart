part of 'todo_filter_bloc.dart';

abstract class TodoFilterState extends Equatable {
  const TodoFilterState();

  @override
  List<Object?> get props => [];
}

class TodoFilterLoading extends TodoFilterState {}

class TodoFilterLoaded extends TodoFilterState{

  final List<Todo> filteredTodos;

  const TodoFilterLoaded({required this.filteredTodos, this.filter = TodoFilter.pending});

  final TodoFilter filter;

  @override
  List<Object?> get props => [
    filteredTodos,
    filter
  ];
}
