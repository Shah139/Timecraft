import 'package:get/get.dart';
import 'home_controller.dart';

class StatsController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final RxDouble overallProgress = 0.0.obs;
  final RxList<Map<String, dynamic>> weeklyStats = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    calculateOverallProgress();
    calculateWeeklyStats();
  }
  
  // Calculate the overall progress percentage across all tasks
  void calculateOverallProgress() {
    final nonCancelledTasks = homeController.allTasks
        .where((task) => !task.isCancelled)
        .toList();
    
    if (nonCancelledTasks.isEmpty) {
      overallProgress.value = 0.0;
      return;
    }
    
    int completed = nonCancelledTasks.where((task) => task.isCompleted).length;
    overallProgress.value = (completed / nonCancelledTasks.length) * 100;
  }
  
  // Calculate weekly statistics for the chart
 void calculateWeeklyStats() {
  weeklyStats.clear();

  final now = DateTime.now();
  final lastSunday = now.subtract(Duration(days: now.weekday % 7));

  List<Map<String, dynamic>> tempStats = [];

  for (int i = 0; i < 7; i++) {
    final day = lastSunday.add(Duration(days: i));
    final dayTasks = homeController.allTasks.where((task) =>
      task.date.year == day.year &&
      task.date.month == day.month &&
      task.date.day == day.day &&
      !task.isCancelled
    ).toList();

    double dayProgress = 0.0;
    if (dayTasks.isNotEmpty) {
      int completed = dayTasks.where((task) => task.isCompleted).length;
      dayProgress = (completed / dayTasks.length) * 100;
    }

    tempStats.add({
      'day': _getDayName(day.weekday),
      'progress': dayProgress,
    });
  }

  // Sort so it matches the order in the UI: [Sun, Mon, Tue, ... Sat]
  weeklyStats.assignAll(tempStats);
}

  
  // Get day name from weekday integer
  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
  
  // Refresh all stats
  void refreshStats() {
    calculateOverallProgress();
    calculateWeeklyStats();
  }
}