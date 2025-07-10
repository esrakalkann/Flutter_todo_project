import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/todo/todo_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/pages/todo/cubit/todo_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ToDoCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoScreen(),
    );
  }
}