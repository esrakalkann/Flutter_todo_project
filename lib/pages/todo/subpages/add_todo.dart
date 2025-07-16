import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/todo/cubit/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Task Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: const InputDecoration(hintText: 'details'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100));
                if (pickedDate != null) {
                  final pickedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) {
                    setState(() {
                      selectedDateTime = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
                    });
                  }
                }
              },
              child: Text(selectedDateTime == null ? 'Date and Time' : selectedDateTime.toString()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            final title = titleController.text.trim();
            final desc = descController.text.trim();
            if (title.isNotEmpty) {
              await context.read<ToDoCubit>().addTodo(title, description: desc, dateTime: selectedDateTime);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Task Ekle'),
        ),
      ],
    );
  }
}
