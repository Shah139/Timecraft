import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stats_controller.dart';

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
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.weeklyStats.length,
                  itemBuilder: (context, index) {
                    final stat = controller.weeklyStats[index];
                    return ListTile(
                      title: Text(stat['day']),
                      subtitle: LinearProgressIndicator(value: stat['progress'] / 100),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
