import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/models/todo.dart';

class ToDo {
  final int id;
  final String text;

  ToDo({required this.id, required this.text});
}


class TodoCubit extends Cubit<List<ToDo>> {
  TodoCubit() : super([]) {
    loadTodos(); // ilk açılışta load
  }

  
  void loadTodos() {
    emit([
      ToDo(id: 1, text: 'deneme'),
      ToDo(id: 2, text: 'Write first commit'),
    ]);
  }

  // add
  void addTodo(String text) {
    final newTodo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
    );
    emit([...state, newTodo]);
  }

  // delete
  void deleteTodo(ToDo todo) {
    final updatedList = state.where((t) => t.id != todo.id).toList();
    emit(updatedList);
  }

  void loadInitialData() {}
}