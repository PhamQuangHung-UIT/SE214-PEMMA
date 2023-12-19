import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_buddy/models/goal_model.dart';

class GoalRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Goal>> fetchGoals(String userId) {
    try {
      return _firestore
          .collection('goals')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                return Goal.fromMap(doc.data() as Map<String, dynamic>);
              }).toList());
    } catch (e) {
      print("Error fetching goals: $e");
      return Stream.empty(); // Trả về Stream rỗng trong trường hợp lỗi
    }
  }

  Future<void> addGoal(Goal newGoal) async {
    try {
      CollectionReference goalsCollection = _firestore.collection('goals');
      await goalsCollection.doc(newGoal.goalId).set(newGoal.toMap());
      print("Added goal successfully with id: " + newGoal.goalId);
    } catch (e) {
      print("Error adding goal: $e");
    }
  }
}
