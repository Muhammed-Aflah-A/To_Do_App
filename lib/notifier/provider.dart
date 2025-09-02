import 'package:flutter/material.dart';
//imported task model page
import 'package:to_do_app/model/task_model.dart';

//theme provider is here------------------------------------------------------------------------------------------------------->
class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;
  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

//task provider is here---------------------------------------------------------------------------------------------------------->
class TaskProvider with ChangeNotifier {
  final taskController = TextEditingController();
  final List<Task> _task = [];
  List<Task> get tasks => _task;

  //task adding here---------------------------------------------------------------------------------------------------------------->
  void addTask(String title) {
    _task.insert(0, Task(title));
    notifyListeners();
  }

  //task deleteing here-------------------------------------------------------------------------------------------------------------->
  void removeTask(int index) {
    _task.removeAt(index);
    notifyListeners();
  }

  //task update here------------------------------------------------------------------------------------------------------------------>
  void updateTask(int index, String newTitle) {
    _task[index].title = newTitle;
    notifyListeners();
  }

  //task status is here---------------------------------------------------------------------------------------------------------------->
  void toggleStatus(int index) {
    _task[index].isCompleted = !_task[index].isCompleted;
    notifyListeners();
  }
}
