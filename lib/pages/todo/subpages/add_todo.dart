import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/todo/cubit/todo_cubit.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Task Title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final taskTitle = _controller.text.trim();
            if (taskTitle.isNotEmpty) {
              context.read<ToDoCubit>().addTodo(taskTitle);
              Navigator.of(context).pop();  
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
