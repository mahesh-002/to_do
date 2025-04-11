class Task {
  String title;
  bool isCompleted;
  DateTime? dueDate;
  String? category;

  Task({
    required this.title,
    this.isCompleted = false,
    this.dueDate,
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
    'dueDate': dueDate?.toIso8601String(),
    'category': category,
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    isCompleted: json['isCompleted'],
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    category: json['category'],
  );
}
