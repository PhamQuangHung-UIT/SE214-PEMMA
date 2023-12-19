import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:budget_buddy/models/budget_model.dart';

class BudgetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Budget>> fetchBudgets(String userId) {
    try {
      return _firestore
          .collection('budgets')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                return Budget.fromMap(doc.data() as Map<String, dynamic>);
              }).toList());
    } catch (e) {
      print("Error fetching budgets: $e");
      return Stream.empty(); // Trả về Stream rỗng trong trường hợp lỗi
    }
  }

  Future<void> addBudget(Budget newBudget) async {
    try {
      CollectionReference budgetCollection = _firestore.collection('budgets');
      await budgetCollection.doc(newBudget.budgetId).set(newBudget.toMap());
      print("Added budget successfully with id: " + newBudget.budgetId);
    } catch (e) {
      print("Error adding budget: $e");
    }
  }
}
