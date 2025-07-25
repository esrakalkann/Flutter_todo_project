import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/local/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //List<ToDoModel> _allTodos = []; // Tüm todoları sakla

  ToDoCubit() : super(ToDoInitial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    emit(ToDoLoading());
    try {
      final QuerySnapshot = await _firestore.collection('todos').get();
      final toDoList = QuerySnapshot.docs.map((doc) {
        final data = doc.data();
        return ToDoModel(
          id: doc.id,
          text: data['text'],
          isCompleted: data['isCompleted'] ?? false,
          description: data['description'],
          dateTime: data['dateTime'] != null
              ? (data['dateTime'] as Timestamp).toDate()
              : null,
        );
      }).toList();

      //List<ToDoModel> toDoList = [];
      // Simüle edilmiş veri yükleme, yapay 3 saniyelik gecikme
      // Burada gerçek bir API çağrısı veya veritabanı sorgusu yapılabilir
      //await Future.delayed(Duration(seconds: 3), () {
      //  toDoList = [
      //   ToDoModel(id: 1, text: 'deneme'),
      // ToDoModel(id: 2, text: 'Write first commit'),
      // ToDoModel(id: 3, text: 'Write second commit'),
      //  ];
      //  });
      //  _allTodos = toDoList;
      // Veriler yüklendikten sonra durumu güncelle
      emit(ToDoLoaded(toDoList));
    } catch (e) {
      // Hata durumunda durumu güncelle
      emit(ToDoError('Veriler yüklenirken bir hata oluştu: $e'));
      return;
    }
  }

  Future <void> addTodo(String text, {String? description, DateTime? dateTime}) async {
    try {
      await _firestore.collection('todos').add({
        'text': text,
        'isCompleted': false,
        'description': description,
        'dateTime': dateTime,
      });
      loadTodos();
    } catch (e) {
      emit(ToDoError('Unable to add task: $e'));
    }

    /*
    if (state is ToDoLoaded) {
      final newTodo = ToDoModel(
        id: DateTime.now().millisecondsSinceEpoch,
        text: text,
        description: description,
        dateTime: dateTime,
      );
      _allTodos = [..._allTodos, newTodo];
      emit(ToDoLoaded([..._allTodos]));
    }
    */
  }

  void deleteTodo(ToDoModel todo) async {
    if (state is ToDoLoaded) {
      // Silme işlemi için mevcut todo listesinden todo'yu kaldır
      /*
      _allTodos.removeWhere((t) => t.id == todo.id);
      emit(ToDoLoaded([..._allTodos]));
      */

      try {
        await _firestore.collection('todos').doc(todo.id).delete();
        loadTodos();
      } catch (e) {
        emit(ToDoError('Unable to delete task: $e'));
      }
    }
  }

  void searchTodos(String query) async{
    emit(ToDoLoading());
    try {
      final snapshot = await _firestore
          .collection('todos')
          .where('text', isGreaterThanOrEqualTo: query)
          .get();

      final results = snapshot.docs.map((doc) {
        final data = doc.data();
        return ToDoModel(
          id: doc.id,
          text: data['text'],
          isCompleted: data['isCompleted'] ?? false,
          description: data['description'],
          dateTime: data['dateTime'] != null
              ? (data['dateTime'] as Timestamp).toDate()
              : null,
        );
      }).toList();
            emit(ToDoLoaded(results));
    } catch (e) {
      emit(ToDoError('Search error: $e'));
    }
  }


  Future <void> toggleTask(String id, bool currentState) async{
    try{
      await _firestore.collection('todos').doc(id).update({
        'isCompleted': !currentState,
      });
      loadTodos();
    }catch(e){
      emit(ToDoError('Unable to update: $e'));

    }


    /*
    if (state is ToDoLoaded) {
      _allTodos = _allTodos.map((todo) {
        if (todo.id == id) {
          return todo.toggleCompletion();
        }

        return todo;
      }).toList();
      emit(ToDoLoaded(_allTodos));
    }
    */
  }

  Future <void> editTodo(String id, String newText) async
  {
    try{

      await _firestore.collection('todos').doc(id).update({
        'text': newText,
      });
      loadTodos();
    } catch(e){
      emit(ToDoError('Unable to update: $e '));
    }

    //}

    /*if (state is ToDoLoaded) {
      _allTodos = _allTodos.map((todo)
      {
        if (todo.id == id) {
          return todo.copyWith(text: newText);
        }

        return todo;
      }).toList();
      emit(ToDoLoaded([..._allTodos]));
    }*/
    
  }
}
