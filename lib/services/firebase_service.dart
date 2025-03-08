import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save task progress
  Future<void> saveTaskProgress(String userId, String taskId, bool isCompleted) async {
    await _db.collection('users').doc(userId).collection('tasks').doc(taskId).set({
      'isCompleted': isCompleted,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Fetch all tasks
  Future<List<Map<String, dynamic>>> getTasks(String userId) async {
    QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('tasks').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Fetch overall progress
  Future<double> getOverallProgress(String userId) async {
    QuerySnapshot snapshot = await _db.collection('users').doc(userId).collection('tasks').get();
    
    if (snapshot.docs.isEmpty) return 0.0;
    
    int totalTasks = snapshot.docs.length;
    int completedTasks = snapshot.docs.where((doc) => doc['isCompleted'] == true).length;

    return (completedTasks / totalTasks) * 100;
  }
}
