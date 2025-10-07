import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
    
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _addTaskPageState();

}

class _addTaskPageState extends State<AddTaskPage> {
  
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;
  int _priority = 1;

  @override
  Widget build(BuildContext context) {

    final taskService = Provider.of<TaskService>(context, listen: false);
  
    return(
      Scaffold(
        appBar: AppBar(title: const Text ('Add Task')),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'name')),
                TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'description')),
                DropdownButton<int>(
                  items: [1,2,3].map((e) => DropdownMenuItem(value: e, child: Text('Priority $e'))).toList(), 
                  onChanged: (value) => setState(() => _priority = value ?? 1)
                ),
                ElevatedButton(onPressed: () async {
                  
                  final id = const Uuid().v4();
                  final deadline = _deadline ?? DateTime.now().add(const Duration(days: 1));
                  final task = Task(
                    id: id,
                    name: _nameController.text,
                    description: _descriptionController.text,
                    priority: _priority,
                    deadline: deadline,
                    isDone: false, 
                  );

                  taskService.addTask(task);
                  Navigator.pop(context);
                }, 
                child: const Text('Save Task'))
              ],
            ),
          ),
        )
    );

  }



}