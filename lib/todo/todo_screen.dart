import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/todo/todo_cubit.dart';
import 'package:flutter_application_1/models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TodoCubit, List<ToDo>>(
                builder: (context, todos) {
                  final filteredTodos = todos.where((todo) {
                    return todo.text.toLowerCase().contains(_searchText);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return ListTile(
                        title: Text(todo.text),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
