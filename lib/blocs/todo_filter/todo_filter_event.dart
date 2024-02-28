part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object?> get props => [];
}

class FilterTodos extends TodoFilterEvent{

  final TodoFilter filter;

  const FilterTodos({this.filter = TodoFilter.all});

  @override
  List<Object?> get props => [];
}

class UpdateFilter extends TodoFilterEvent{
  const UpdateFilter();
  @override
  List<Object?> get props => [];
}
