import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/todo/todo_cubit.dart';


@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  final List<ToDo> todos;
  TodoLoaded(this.todos);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}