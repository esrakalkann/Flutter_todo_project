import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/local/todo_model.dart';

class TaskDetail extends StatelessWidget {
  final ToDoModel todo;

  const TaskDetail({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Task Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title: ${todo.text}'),
          const SizedBox(height: 8),
          Text('Completed: ${todo.isCompleted ? "Yes" : "No"}'),
          if (todo.description != null) Text('Description: ${todo.description}'),
          if (todo.dateTime != null) Text('Date: ${todo.dateTime}'),
        ],
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
