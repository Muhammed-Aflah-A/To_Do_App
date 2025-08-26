import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class TaskProvider with ChangeNotifier {
  List _task = [];
  final taskController = TextEditingController();
  // bool? checked = false;
  List get tasks => _task;
  void addTask(titles) {
    _task.insert(0, titles);
    notifyListeners();
  }

  void removeTask(index) {
    _task.removeAt(index);
    notifyListeners();
  }
}
