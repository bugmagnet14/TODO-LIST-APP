import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  late Box<Task> _taskBox;

  List<Task> get tasks => _tasks;

  Future<void> init() async {
    _taskBox = await Hive.openBox<Task>('taskBox');
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    _taskBox.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _taskBox.delete(task.key);
    notifyListeners();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    task.save();
    notifyListeners();
  }
}
