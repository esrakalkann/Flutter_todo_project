part of 'todo_cubit.dart';

@immutable
//kendisinden başka sınıf üretilemez
sealed class ToDoState {}

final class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDoModel> toDoList;
  ToDoLoaded(this.toDoList);
}

class ToDoError extends ToDoState {
  final String message;
  ToDoError(this.message);
}