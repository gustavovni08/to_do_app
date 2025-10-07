import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../widgets/task_item.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filter = 'all'; // all, open, completed, overdue

  @override
  Widget build(BuildContext context) {
    
    final taskService = Provider.of<TaskService>(context);
    List tasks;

    switch(filter) {
      case 'open':
        tasks = taskService.openTask;
        break;
      case 'completed':
        tasks = taskService.closedTask;
        break;
       case 'overdue':
        tasks = taskService.overdueTask;
        break;
      default:
        tasks = taskService.tasks;
    }

    return(
      Scaffold(
        appBar: AppBar(
         title: const Text('ToDo App'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => setState(() {
                filter = value;
              }),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'all', child: Text('All')),
                const PopupMenuItem(value: 'open', child: Text('Open')),
                const PopupMenuItem(value: 'completed', child: Text('Completed')),
                const PopupMenuItem(value: 'overdue', child: Text('Overdue')),
              ],)
          ],
        ),
        body: ListView.builder(
          itemCount: tasks.length,  
          itemBuilder: (context, index) => TaskItem(task: tasks[index])
        ),

        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage())
          );
        },
        child: const Icon(Icons.add)),  
      )
    );
  }
}