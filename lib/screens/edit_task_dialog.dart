import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:todo_list_app/models/task.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdate;

  EditTaskDialog({required this.task, required this.onUpdate});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late int priority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
    priority = widget.task.priority;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (titleController.text.isNotEmpty) {
      final updatedTask = Task(
        titleController.text,
        descriptionController.text,
        widget.task.isCompleted,
        priority,
      );
      widget.onUpdate(updatedTask);
      Navigator.of(context).pop();
    } else {
      // Handle empty title case (e.g., show a Snackbar)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          DropdownButton<int>(
            value: priority,
            onChanged: (int? newValue) {
              setState(() {
                priority = newValue!;
              });
            },
            items: [
              DropdownMenuItem(value: 0, child: Text('Low')),
              DropdownMenuItem(value: 1, child: Text('Medium')),
              DropdownMenuItem(value: 2, child: Text('High')),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: _submit, child: Text('Save')),
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
      ],
    );
  }
}
