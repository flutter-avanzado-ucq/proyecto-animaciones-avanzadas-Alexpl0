import 'package:flutter/material.dart';

class Task {
  String title;
  bool done;
  DateTime? date; 
  // # 18 de Junio; se agregó propiedad dueDate como alias de date para compatibilidad
  DateTime? get dueDate => date;
  set dueDate(DateTime? value) => date = value;

  Task({required this.title, this.done = false, this.date}) {
    date ??= DateTime.now(); 
  }
}

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  // # 18 de Junio; se corrigió parámetro de date a dueDate para consistencia
  void addTask(String title, {DateTime? dueDate}) {
    _tasks.insert(0, Task(title: title, date: dueDate));
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

  // # 18 de Junio; se corrigió parámetro de date a newDate para consistencia
  void updateTask(int index, String newTitle, {DateTime? newDate}) {
    _tasks[index].title = newTitle;
    _tasks[index].date = newDate ?? DateTime.now();
    notifyListeners();
  }
}