import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/add_task_view.dart';
import '../views/stats_view.dart';
import '../bindings/home_binding.dart';
import '../bindings/add_task_binding.dart';
import '../bindings/stats_binding.dart';

class AppRoutes {
  static const String home = '/home';
  static const String addTask = '/add_task';
  static const String stats = '/stats';
  
  static final routes = [
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: addTask,
      page: () => AddTaskView(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: stats,
      page: () => StatsView(),
      binding: StatsBinding(),
    ),
  ];
}