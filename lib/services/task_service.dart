import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskService extends ChangeNotifier {
  
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task){
  
    _tasks.add(task);
    notifyListeners();
  
  }

  void removeTask(Task task){
    
    _tasks.remove(task);
    notifyListeners();
  
  }

  void toogleCompleted(Task task){
    
    final index = _tasks.indexOf(task);
    
    if(index != -1){
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }

  }

 void updateTask(Task oldTask, Task updatedTask) {
    final index = _tasks.indexOf(oldTask);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  List<Task> get openTask => _tasks.where((task) => !task.isDone).toList();

  List<Task> get closedTask => _tasks.where((task) => task.isDone).toList();

   List<Task> get overdueTask => _tasks
      .where((task) => !task.isDone && task.deadline.isBefore(DateTime.now()))
      .toList();

}