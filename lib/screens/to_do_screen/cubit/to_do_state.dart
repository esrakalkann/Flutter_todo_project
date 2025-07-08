part of 'to_do_cubit.dart';

@immutable
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
