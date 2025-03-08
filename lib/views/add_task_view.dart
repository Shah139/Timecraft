import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/add_task_controller.dart';
import '../widgets/task_tile.dart';

class AddTaskView extends GetView<AddTaskController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Column(
        children: [
          // Calendar
          Obx(() => _buildCalendar()),
          
          // Divider
          const Divider(height: 0),
          
          // Tasks for selected date
          Expanded(
            child: Obx(() => _buildTasksForSelectedDate()),
          ),
        ],
      ),
      // Add new task button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Add Task tab is selected
        onTap: (index) {
          if (index == 0) {
            Get.toNamed('/home');
          } else if (index == 1) {
            // Already on add task
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
  
  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: controller.selectedDate.value,
      selectedDayPredicate: (day) {
        return isSameDay(controller.selectedDate.value, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        controller.changeSelectedDate(selectedDay);
      },
      calendarFormat: CalendarFormat.month,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
      ),
    );
  }
  
  Widget _buildTasksForSelectedDate() {
    final tasksForDate = controller.tasksForSelectedDate;
    
    if (tasksForDate.isEmpty) {
      return Center(
        child: Text(
          'No tasks for ${_formatDate(controller.selectedDate.value)}. Add some!'
        ),
      );
    }
    
    return ListView.builder(
      itemCount: tasksForDate.length,
      itemBuilder: (context, index) {
        final task = tasksForDate[index];
        return TaskTile(
          task: task,
          onCompleted: (isCompleted) {
            if (isCompleted) {
              controller.homeController.markAsCompleted(task.id);
              controller.updateTasksForSelectedDate();
            }
          },
          onCancelled: () {
            controller.homeController.cancelTask(task.id);
            controller.updateTasksForSelectedDate();
          },
        );
      },
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        title: Text('Add Task for ${_formatDate(controller.selectedDate.value)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter task title',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter task description',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                controller.addTask(
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
              } else {
                Get.snackbar(
                  'Error',
                  'Title cannot be empty',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}