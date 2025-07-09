import 'package:flutter/material.dart';
import 'package:flutter_application_1/todo/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/add_todo.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo List')),

        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ToDoCubit, ToDoState>(
                builder: (context, state) {
                  return TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<ToDoCubit>().searchTodos(value);
                    },
                  );
                },
              ),
            ),

            // Todo list
            Expanded(
              child: BlocBuilder<ToDoCubit, ToDoState>(
                builder: (context, state) {
                  if (state is ToDoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ToDoError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ToDoLoaded) {
                    final todos = state.toDoList;

                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return ListTile(
                          title: Text(
                            todo.text,
                            style: TextStyle(
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) {
                              context.read<ToDoCubit>().toggleTask(todo.id);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<ToDoCubit>().deleteTodo(todo);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No todos found'));
                },
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddTaskDialog(),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
