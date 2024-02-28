import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo/todo_bloc.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _todoSubscription;
  TodoFilterBloc({required TodoBloc todoBloc}) :
        _todoBloc = todoBloc,
        super(TodoFilterLoading()) {
    on<FilterTodos>(_onFilter);
    on<UpdateFilter>(_onUpdateFilter);
    _todoSubscription = _todoBloc.stream.listen((state) {
      add(const UpdateFilter());
    });
  }

  void _onUpdateFilter(UpdateFilter event, emit){
    if(state is TodoFilterLoading){
      add(const FilterTodos(filter: TodoFilter.pending));
    }

    if(state is TodoFilterLoaded){
      final state = this.state as TodoFilterLoaded;
      add(FilterTodos(filter: state.filter))
;    }
  }

  void _onFilter(FilterTodos event, emit){
    final state = _todoBloc.state;
    if(state is TodoLoaded){
      List<Todo> todos = state.todos.where((element) {
        switch (event.filter){
          case TodoFilter.all:
            return true;
          case TodoFilter.completed:
            return element.completed == true;
          case TodoFilter.pending:
            return element.completed == false;
        }
      }).toList();
      emit(TodoFilterLoaded(filteredTodos: todos));
    }
  }
}
