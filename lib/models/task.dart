class Task {
  String title;
  String? note;
  DateTime? dueDate;
  String? category;
  bool isCompleted;
  int priority; // 0 = Low, 1 = Medium, 2 = High

  Task({
    required this.title,
    this.note,
    this.dueDate,
    this.category,
    this.isCompleted = false,
    this.priority = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'dueDate': dueDate?.toIso8601String(),
      'category': category,
      'isCompleted': isCompleted,
      'priority': priority,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      note: json['note'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      category: json['category'],
      isCompleted: json['isCompleted'] ?? false,
      priority: json['priority'] ?? 1,
    );
  }
}
