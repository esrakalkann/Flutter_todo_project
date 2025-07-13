import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/local/todo_model.dart';

class TaskDetail extends StatelessWidget {
  final ToDoModel todo;

  const TaskDetail({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.text, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Completed: ${todo.isCompleted ? "Yes" : "No"}'),
            const SizedBox(height: 8),
            if (todo.description != null)
              Text('Description: ${todo.description}'),
               const SizedBox(height: 8),
            if (todo.dateTime != null) Text('Date: ${todo.dateTime}'),
          ],
        ),
      ),
    );
  }
}
