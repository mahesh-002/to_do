import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

class TaskStorage {
  static const _key = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_key, taskList);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getStringList(_key);
    if (taskList != null) {
      return taskList.map((t) => Task.fromJson(jsonDecode(t))).toList();
    }
    return [];
  }
}
