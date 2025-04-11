import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/main.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/services/task_storage.dart';
import 'package:to_do/widgets/task_tile.dart';

class TodoHomePage extends StatefulWidget {
  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  List<Task> tasks = [];
  final TextEditingController _controller = TextEditingController();
  DateTime? _dueDate;
  String? _category;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await TaskStorage.loadTasks();
    setState(() => tasks = loadedTasks);
  }

  Future<void> _saveTasks() async => TaskStorage.saveTasks(tasks);

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      final task = Task(
        title: _controller.text,
        dueDate: _dueDate,
        category: _category,
      );
      setState(() {
        tasks.add(task);
        _controller.clear();
        _dueDate = null;
        _category = null;
      });
      _saveTasks();
    }
  }

  void _toggleComplete(Task task) {
    setState(() => task.isCompleted = !task.isCompleted);
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() => tasks.remove(task));
    _saveTasks();
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  void _toggleTheme() {
    themeNotifier.value =
    themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do App"),
        actions: [
          IconButton(
            icon: Icon(theme.brightness == Brightness.light
                ? Icons.nightlight_round
                : Icons.wb_sunny),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Enter a task",
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDueDate,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter category",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _category = value,
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text("Add Task"),
          ),
          Expanded(
            child: ListView(
              children: tasks.map((task) => TaskTile(
                task: task,
                onComplete: () => _toggleComplete(task),
                onDelete: () => _deleteTask(task),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
