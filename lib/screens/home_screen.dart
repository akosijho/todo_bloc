import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo/todo_bloc.dart';
import 'package:todo_bloc/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/screens/add_todo.dart';

import '../models/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Center(
                child: Text('Bloc Patten todos',
                    style: TextStyle(color: Colors.white))),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTodoScreen()));
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ))
            ],
            bottom: TabBar(
                onTap: (index) {
                  switch (index) {
                    case 0:
                      BlocProvider.of<TodoFilterBloc>(context)
                          .add(const FilterTodos(filter: TodoFilter.all));
                      break;
                    case 1:
                      BlocProvider.of<TodoFilterBloc>(context)
                          .add(const FilterTodos(filter: TodoFilter.completed));
                      break;
                  }
                },
                tabs: const [
                  Tab(
                      icon: Icon(
                    Icons.pending,
                    color: Colors.white,
                  )),
                  Tab(
                      icon: Icon(
                    Icons.add_task,
                    color: Colors.white,
                  )),
                ]),
          ),
          body: TabBarView(
            children: [_builBody("Pending Todos"), _builBody("Completed")],
          )),
    );
  }

  Widget _todo(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  todo.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  todo.description,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(todo.severity.name))
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(
                          UpdateTodo(todo: todo.copyWith(completed: true)));
                    },
                    icon: Icon(
                      Icons.add_task,
                      color: todo.completed ? Colors.green : Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      if(todo.completed == false) context.read<TodoBloc>().add(DeleteTodo(todo: todo));
                    },
                    icon: const Icon(Icons.cancel))
              ],
            )
          ],
        ),
      ),
    );
  }

  BlocBuilder<TodoFilterBloc, TodoFilterState> _builBody(String title) {
    return BlocBuilder<TodoFilterBloc, TodoFilterState>(
      builder: (context, state) {
        if (state is TodoFilterLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TodoFilterLoaded) {
          if (state.filteredTodos.isEmpty) {
            return const Center(
                child: Text(
              'No todos. Move you a**',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.filteredTodos.length,
                    itemBuilder: (context, index) =>
                        _todo(context, state.filteredTodos[index]))
              ],
            ),
          );
        }
        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
