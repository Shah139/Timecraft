class Task {
  String id;
  String title;
  String description;
  DateTime date;
  bool isCompleted;
  bool isCancelled;
  String priority; 

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
    this.isCancelled = false,
    this.priority = 'Medium',
  });

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'isCancelled': isCancelled,
      'priority' : priority,
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      priority: json['priority'] ?? 'Medium',
    );
  }
}