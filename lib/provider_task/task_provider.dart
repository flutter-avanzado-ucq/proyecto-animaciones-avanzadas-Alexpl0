import 'package:flutter/material.dart';

class Task {
  String title;
  bool done;
  DateTime? date; 

  Task({required this.title, this.done = false, this.date}) {
    date ??= DateTime.now(); 
  }
}

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title, {DateTime? date}) {
    _tasks.insert(0, Task(title: title, date: date));
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].done = !_tasks[index].done;
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  // 04 de junio - se agregó función para actualizar tareas existentes
  void updateTask(int index, String newTitle, {DateTime? date}) {
    _tasks[index].title = newTitle;
    _tasks[index].date = date ?? DateTime.now();
    notifyListeners();
  }
}