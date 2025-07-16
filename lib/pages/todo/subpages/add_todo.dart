import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/todo/cubit/todo_cubit.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();
    DateTime? _selectedDateTime;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(padding: const EdgeInsets.all(16),
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Task Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(hintText: 'details'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    _selectedDateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );

                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Date picked: $_selectedDateTime")),
                    );
                  }
                }
              },
              child: const Text('Date and Time'),
            ),
          
          const Spacer(),
     
      
     
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final desc = _descController.text.trim();
            if (title.isNotEmpty) {
              context.read<ToDoCubit>().addTodo(
                title,
                description: desc,
                dateTime: _selectedDateTime,
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        )
        
      ],
    ),
    ),

    );
  }
}
