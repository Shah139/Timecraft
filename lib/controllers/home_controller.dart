import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';

class HomeController extends GetxController {
  final RxList<Task> allTasks = <Task>[].obs;
  final RxDouble progressPercentage = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    // We'll replace this with Firebase later
    // For now, using local data
    loadTasks();
  }
  
  // Get today's tasks
  List<Task> get todayTasks {
    final today = DateTime.now();
    return allTasks.where((task) => 
      task.date.year == today.year && 
      task.date.month == today.month && 
      task.date.day == today.day &&
      !task.isCancelled
    ).toList();
  }
  
  // Calculate progress percentage for today
  void calculateTodayProgress() {
    if (todayTasks.isEmpty) {
      progressPercentage.value = 0.0;
      return;
    }
    
    int completed = todayTasks.where((task) => task.isCompleted).length;
    double percentage = (completed / todayTasks.length) * 100;
    progressPercentage.value = percentage;
    progressPercentage.refresh();
  }
  
  // Mark task as completed
  void markAsCompleted(String taskId) {
    final index = allTasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      allTasks[index].isCompleted = true;
      allTasks.refresh();
      calculateTodayProgress();
      update();
      saveTasks(); // We'll implement this with Firebase later
    }
  }
  
  // Cancel task
  void cancelTask(String taskId) {
    final index = allTasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      allTasks[index].isCancelled = true;
      allTasks.refresh();
      calculateTodayProgress();
      saveTasks();
    }
  }
  
  // Add a new task
  void addTask(String title, String description, DateTime date) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      date: date,
    );
    
    allTasks.add(task);
    if (isToday(date)) {
      calculateTodayProgress();
    }
    saveTasks();
  }
  
  // Check if a date is today
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  // These methods will be replaced with Firebase later
  void loadTasks() {
    // For demo, let's add some sample tasks
    addTask('Finish Project Report', 'Complete the quarterly report', DateTime.now());
    addTask('Buy Groceries', 'Milk, eggs, bread', DateTime.now());
    calculateTodayProgress();
  }
  
  void saveTasks() {
    // This will be implemented with Firebase later
    print('Tasks saved: ${allTasks.length}');
  }
}