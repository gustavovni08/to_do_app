// ignore: unused_import
import 'package:flutter/material.dart';

class Task {
    
    final String id;
    final String name;
    final String? description;
    final int priority;
    final DateTime deadline;
    bool isDone;

    Task({
        required this.id,
        required this.name,
        required this.description,
        required this.priority,
        required this.deadline,
        required this.isDone,
    });

    bool get isLate => !isDone && deadline.isBefore(DateTime.now());

    Task copyWith({
        String? id,
        String? name,
        String? description,
        int? priority,
        DateTime? deadline,
        bool? isDone,
    }) 
    {
        return Task(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          priority: priority ?? this.priority,
          deadline: deadline ?? this.deadline,
          isDone: isDone ?? this.isDone,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'priority': priority,
        'deadline': deadline.toIso8601String(),
        'isDone': isDone,
    };

    factory Task.fromJson(Map<String, dynamic> json) {
        return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      priority: json['priority'],
      deadline: DateTime.parse(json['deadline']),
      isDone: json['isDone'],
        );
    }

    @override
    String toString() {
        return 'Task(name: $name, priority: $priority, deadline: $deadline, isDone: $isDone)';
    }

    @override
     bool operator ==(Object other) =>
        identical(this, other) ||
        other is Task && runtimeType == other.runtimeType && id == other.id;

     @override
     int get hashCode => id.hashCode;
    
}