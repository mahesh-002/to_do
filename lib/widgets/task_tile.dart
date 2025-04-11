import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const TaskTile({
    required this.task,
    required this.onComplete,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? theme.colorScheme.primary : theme.colorScheme.outline,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.dueDate != null)
              Text('Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}'),
            if (task.category != null)
              Text('Category: ${task.category}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: onComplete,
              color: theme.colorScheme.primary,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
              color: theme.colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
