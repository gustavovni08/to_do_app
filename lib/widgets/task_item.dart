import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {

    final service = Provider.of<TaskService>(context, listen: false);

    return Card(
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isLate && !task.isDone ? Colors.red : Colors.black,
          ),
        ),
        subtitle: Text(
          'Deadline: ${task.deadline}',
        ),
        trailing: IconButton(
          icon: Icon(
            task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onPressed: () {
            service.toogleCompleted(task);
          },
        ),
      )
    );
  }
}