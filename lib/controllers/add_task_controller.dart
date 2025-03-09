import 'package:get/get.dart';
import '../models/task_model.dart';
import 'home_controller.dart';

class AddTaskController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxList<Task> tasksForSelectedDate = <Task>[].obs;
  
  final HomeController homeController = Get.find<HomeController>();
  
  @override
  void onInit() {
    super.onInit();
    updateTasksForSelectedDate();
  }
  
  // Change the selected date
  void changeSelectedDate(DateTime date) {
    selectedDate.value = date;
    updateTasksForSelectedDate();
  }
  
  // Update the list of tasks for the selected date
  void updateTasksForSelectedDate() {
    final date = selectedDate.value;
    tasksForSelectedDate.value = homeController.allTasks
        .where((task) => 
            task.date.year == date.year && 
            task.date.month == date.month && 
            task.date.day == date.day &&
            !task.isCancelled)
        .toList();
  }
  
  // Add a new task for the selected date
  void addTask(String title, String description, [String priority = 'Medium']) {
    homeController.addTask(title, description, selectedDate.value, priority: priority);
    updateTasksForSelectedDate();
  }
}