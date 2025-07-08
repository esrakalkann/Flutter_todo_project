import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/todo.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  List<ToDoModel> _allTodos = []; // Tüm todoları sakla

  ToDoCubit() : super(ToDoInitial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    // Burada verileri yüklerken bir gecikme simüle ediyoruz
    // Gerçek uygulamada bu, bir API çağrısı veya veritabanı sorgusu olabilir
    // Örnek olarak, 1 saniyelik bir gecikme ekliyoruz
    emit(ToDoLoading());
    try {
      List<ToDoModel> toDoList = [];
      // Simüle edilmiş veri yükleme, yapay 3 saniyelik gecikme
      // Burada gerçek bir API çağrısı veya veritabanı sorgusu yapılabilir
      await Future.delayed(Duration(seconds: 3), () {
        toDoList = [ToDoModel(id: 1, text: 'deneme'), ToDoModel(id: 2, text: 'Write first commit'), ToDoModel(id: 3, text: 'Write second commit')];
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
      //id benzersiz olmalı bu yüzden DateTime.now().millisecondsSinceEpoch kullanıldı
      final newTodo = ToDoModel(id: DateTime.now().millisecondsSinceEpoch, text: text);
      emit(ToDoLoaded([..._allTodos, newTodo])); // Yeni todo'yu mevcut listeye ekle
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
      final filtered = _allTodos.where((todo) => todo.text.toLowerCase().contains(query.toLowerCase())).toList();
      emit(ToDoLoaded(filtered)); // Filtrelenmiş todoları göster
    }
  }
}
