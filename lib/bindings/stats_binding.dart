import 'package:get/get.dart';
import '../controllers/stats_controller.dart';

class StatsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StatsController>(StatsController());
  }
}