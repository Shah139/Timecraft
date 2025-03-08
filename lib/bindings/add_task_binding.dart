import 'package:get/get.dart';
import '../controllers/add_task_controller.dart';

class AddTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddTaskController>(AddTaskController());
  }
}