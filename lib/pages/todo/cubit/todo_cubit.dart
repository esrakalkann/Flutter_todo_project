import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/local/todo_model.dart';

part 'todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  List<ToDoModel> _allTodos = []; // Tüm todoları sakla

  ToDoCubit() : super(ToDoInitial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    emit(ToDoLoading());
    try {
      List<ToDoModel> toDoList = [];
      // Simüle edilmiş veri yükleme, yapay 3 saniyelik gecikme
      // Burada gerçek bir API çağrısı veya veritabanı sorgusu yapılabilir
      await Future.delayed(Duration(seconds: 3), () {
        toDoList = [
          ToDoModel(id: 1, text: 'deneme'),
          ToDoModel(id: 2, text: 'Write first commit'),
          ToDoModel(id: 3, text: 'Write second commit'),
        ];
      });
      _allTodos = toDoList;
      // Veriler yüklendikten sonra durumu güncelle
      emit(ToDoLoaded(toDoList));
    } catch (e) {
      // Hata durumunda durumu güncelle
      emit(ToDoError('Veriler yüklenirken bir hata oluştu: $e'));
      return;
    }
  }

  void addTodo(String text) {
    if (state is ToDoLoaded) {
      final newTodo = ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch,
        text: text,
      );
      _allTodos = [..._allTodos, newTodo];
      emit(ToDoLoaded([..._allTodos]));
    }
  }

  void deleteTodo(ToDoModel todo) {
    if (state is ToDoLoaded) {
      // Silme işlemi için mevcut todo listesinden todo'yu kaldır

      _allTodos.removeWhere((t) => t.id == todo.id);
      emit(ToDoLoaded([..._allTodos]));
    }
  }

  void searchTodos(String query) {
    if (query.isEmpty) {
      emit(ToDoLoaded([..._allTodos])); // Tüm todoları göster
    } else {
      // Arama sorgusuna göre todoları filtrele
      final filtered = _allTodos
          .where(
            (todo) => todo.text.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(ToDoLoaded(filtered)); // Filtrelenmiş todoları göster
    }
  }

  void toggleTask(int id) {
    if (state is ToDoLoaded) {
      _allTodos = _allTodos.map((todo) {
        if (todo.id == id) {
          return todo.toggleCompletion();
        }

        return todo;
      }).toList();
      emit(ToDoLoaded(_allTodos));
    }
  }

  void editTodo(int id, String newText) {
    if (state is ToDoLoaded) {
      _allTodos = _allTodos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(text: newText);
        }

        return todo;
      }).toList();
      emit(ToDoLoaded([..._allTodos]));
    }
  }
}
