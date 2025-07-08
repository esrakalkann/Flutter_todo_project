import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/todo/todo_cubit.dart';
import 'package:flutter_application_1/models/todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: BlocBuilder<TodoCubit, List<ToDo>>(
          builder: (context, todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.text),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
