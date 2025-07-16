import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/local/todo_model.dart';

part 'todo_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ToDoCubit() : super(ToDoInitial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    log('Loading todos...');
    emit(ToDoLoading());
    try {
      final querySnapshot = await _firestore.collection('todos').get();

      final toDoList = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ToDoModel(
          id: doc.id,
          text: data['text'],
          isCompleted: data['isCompleted'] ?? false,
          description: data['description'],
          dateTime: data['dateTime'] != null ? (data['dateTime'] as Timestamp).toDate() : null,
        );
      }).toList();
      emit(ToDoLoaded(toDoList));
    } catch (e) {
      emit(ToDoError('Veriler yüklenirken bir hata oluştu: $e'));
      return;
    }
  }

  Future<void> addTodo(String text, {String? description, DateTime? dateTime}) async {
    log('Adding todo: $text');
    try {
      final docRef = await _firestore.collection('todos').add({'text': text, 'isCompleted': false, 'description': description, 'dateTime': dateTime});
      log('Todo added: $text, id: ${docRef.id}');
      await Future.delayed(const Duration(milliseconds: 300)); // Firestore'ın veriyi işlemesi için kısa bir bekleme
      await loadTodos();
    } catch (e) {
      log('Error adding todo: $e');
      emit(ToDoError('Unable to add task: $e'));
    }
  }

  void deleteTodo(ToDoModel todo) async {
    if (state is ToDoLoaded) {
      try {
        await _firestore.collection('todos').doc(todo.id).delete();
        loadTodos();
      } catch (e) {
        emit(ToDoError('Unable to delete task: $e'));
      }
    }
  }

  void searchTodos(String query) async {
    emit(ToDoLoading());
    try {
      final snapshot = await _firestore.collection('todos').where('text', isGreaterThanOrEqualTo: query).get();

      final results = snapshot.docs.map((doc) {
        final data = doc.data();
        return ToDoModel(
          id: doc.id,
          text: data['text'],
          isCompleted: data['isCompleted'] ?? false,
          description: data['description'],
          dateTime: data['dateTime'] != null ? (data['dateTime'] as Timestamp).toDate() : null,
        );
      }).toList();
      emit(ToDoLoaded(results));
    } catch (e) {
      emit(ToDoError('Search error: $e'));
    }
  }

  Future<void> toggleTask(String id, bool currentState) async {
    try {
      await _firestore.collection('todos').doc(id).update({'isCompleted': !currentState});
      loadTodos();
    } catch (e) {
      emit(ToDoError('Unable to update: $e'));
    }
  }

  Future<void> editTodo(String id, String newText) async {
    try {
      await _firestore.collection('todos').doc(id).update({'text': newText});
      loadTodos();
    } catch (e) {
      emit(ToDoError('Unable to update: $e '));
    }
  }
}
