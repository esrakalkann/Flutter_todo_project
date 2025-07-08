import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/to_do_screen/cubit/to_do_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Todo List')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ToDoCubit, ToDoState>(
                builder: (context, state) {
                  return TextField(
                    decoration: const InputDecoration(labelText: 'Search', border: OutlineInputBorder()),
                    onChanged: (value) {
                      context.read<ToDoCubit>().searchTodos(value);
                    },
                  );
                },
              ),
            ),
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
                        return ListTile(title: Text(todo.text));
                      },
                    );
                  }
                  return const Center(child: Text('No todos found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
