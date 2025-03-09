import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/task_tile.dart';
import 'package:timecraft/widgets/progress_indicator.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Stack(
    children: [
      // Purple Background
      Container(
        height: 250, // Adjust as needed
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurple], // Customize colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50), // Space for status bar

          // User Info Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back 👋",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                          'User', // Replace with user's name from GetX controller
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Progress Card
         Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => _buildProgressCard()),
            ),
          ),
          


          const SizedBox(height: 10),

          // Today's Tasks Text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Today\'s tasks:',
              style: TextStyle(
                color: Color.fromARGB(115, 43, 41, 41),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Today's Tasks List
          Expanded(
            child: Obx(() => _buildTasksList()),
          ),
        ],
      ),
    ],
  ),

  bottomNavigationBar: BottomNavigationBar(
    currentIndex: 0,
    onTap: (index) {
      if (index == 1) {
        Get.toNamed('/add_task');
      } else if (index == 2) {
        Get.toNamed('/stats');
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
  
 Widget _buildProgressCard() {
  return Stack(
    clipBehavior: Clip.none, // Allow overflow
    children: [
      Card(
        margin: EdgeInsets.all(16), // Adjust this if necessary
        child: Container(
          height: 320,
          width: 350, // Adjust height if needed
          padding: EdgeInsets.all(16), // Reduce this if needed
          child: Column(
            children: [
              Text(
                " ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Circular Progress Indicator Overlapping
      Positioned(
        top: 40,
        left: 0,
        right: 0,
        child: CircularProgressIndicatorWidget(
          percentage: controller.progressPercentage.value / 100,
        ),
      ),
    ],
  );
}

  
  Widget _buildTasksList() {
    final todayTasks = controller.todayTasks;
    
    if (todayTasks.isEmpty) {
      return const Center(
        child: Text('No tasks for today. Add some tasks!'),
      );
    }
    
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: todayTasks.length,
      itemBuilder: (context, index) {
        final task = todayTasks[index];
        return TaskTile(
          task: task,
          onCompleted: (isCompleted) {
            if (isCompleted) {
              controller.markAsCompleted(task.id);
            }
          },
          onCancelled: () {
            controller.cancelTask(task.id);
          },
        );
      },
    );
  }
}
