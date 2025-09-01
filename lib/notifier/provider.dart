import 'package:flutter/material.dart';
import 'package:to_do_app/model/task_model.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class TaskProvider with ChangeNotifier {
 final List<Task> _task = [];
List<Task> get tasks => _task;
final taskController = TextEditingController();

void addTask(String title) {
  _task.insert(0, Task(title));
  notifyListeners();
}

void removeTask(int index) {
  _task.removeAt(index);
  notifyListeners();
}

void updateTask(int index, String newTitle) {
  _task[index].title = newTitle;
  notifyListeners();
}

void toggleStatus(int index) {
  _task[index].isCompleted = !_task[index].isCompleted;
  notifyListeners();
}
}
