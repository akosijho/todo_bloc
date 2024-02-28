import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/todo/todo_bloc.dart';
import 'package:todo_bloc/models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {



  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  Severity selectedSeverity = Severity.values.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: const Center(
              child: Text(
            'Add Todo',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoLoaded) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Todo Added')));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _formField(name, 'Todo Name'),
              const SizedBox(height: 8),
              _formField(description, 'Todo Description'),
              const SizedBox(height: 8),
              const Text('Severity'),
              const SizedBox(height: 8),
              Row(
                children: Severity.values
                    .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        onTap: () {
                              setState(() {
                                selectedSeverity = e;
                              });
                            },
                        child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                decoration: BoxDecoration(
                                    color: selectedSeverity == e
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      color: selectedSeverity == e
                                          ? Colors.white
                                          : Colors.black),
                                )),
                      ),
                    ))
                    .toList(),
              ),
              Expanded(child: Container()),
              TextButton(
                onPressed: () {
                  context.read<TodoBloc>().add(AddTodo(
                      todo: Todo(
                          id: _generateRandomString(),
                          name: name.text,
                          severity: selectedSeverity,
                          description: description.text)));
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.black,
                    ),
                    fixedSize: MaterialStatePropertyAll(
                        Size(MediaQuery.sizeOf(context).width - 16, 60)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.white)))),
                child: const Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ]),
          ),
        ));
  }

  Widget _formField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  String _generateRandomString() {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        6, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }
}
