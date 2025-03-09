import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'package:intl/intl.dart'; // Make sure to add this dependency

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool)? onCompleted;
  final VoidCallback? onCancelled;

  const TaskTile({
    Key? key,
    required this.task,
    this.onCompleted,
    this.onCancelled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task title and main content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    color: task.isCompleted ? Colors.grey : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: task.isCompleted ? Colors.grey : Colors.black54,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Priority, Deadline
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Priority
                Row(
                  children: [
                    const Text(
                      "Priority: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(task.priority).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        task.priority,
                        style: TextStyle(
                          color: _getPriorityColor(task.priority),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Deadline
                Row(
                  children: [
                    const Text(
                      "Deadline: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _formatDate(task.date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Bottom actions
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Complete button
                TextButton.icon(
                  icon: Icon(
                    task.isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                    color: task.isCompleted ? Colors.green : Colors.grey,
                  ),
                  label: Text(
                    task.isCompleted ? 'Completed' : 'Complete',
                    style: TextStyle(
                      color: task.isCompleted ? Colors.green : Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    if (onCompleted != null) {
                      onCompleted!(!task.isCompleted);
                    }
                  },
                ),
                // Cancel button
                TextButton.icon(
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: onCancelled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get priority color
  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
  
  // Format date to match the design
  String _formatDate(DateTime date) {
    return DateFormat('d\'th\' MMMM').format(date);
  }
}