import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/todo.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodoEvent>(_onLoadTodos);
    on<AddTodo>(_addTodo);
    on<DeleteTodo>(_deleteTodo);
    on<UpdateTodo>(_updateTodo);
  }

  void _addTodo(event, emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onLoadTodos(event, emit) {
    emit(TodoLoading());
    emit(TodoLoaded(todos: event.todos));
  }

  void _deleteTodo(event, emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoading());
      final todos = state.todos;
      todos.remove(event.todo);
      emit(TodoLoaded(todos: todos));
    }
  }

  void _updateTodo(UpdateTodo event, emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(TodoLoading());
      final List<Todo> todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(TodoLoaded(todos: todos));
    }
  }
}