import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stats_controller.dart';
import '../widgets/bar_chart_widget.dart'; // Import the bar chart widget

class StatsView extends StatelessWidget {
  final StatsController controller = Get.put(StatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Statistics")),
       body: Column(
        children: [
          const SizedBox(height: 20),
          Obx(() => Text(
                "Overall Progress: ${controller.overallProgress.value.toStringAsFixed(2)}%",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 20),
          BarChartWidget(), // Add the bar chart here
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Add Task tab is selected
        onTap: (index) {
          if (index == 0) {
            Get.toNamed('/home');
          } else if (index == 1) {
            Get.toNamed('/add_task');
          } else if (index == 2) {
            // Already on add task
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'Add Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}
