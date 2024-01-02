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

  Future<void> getBudgetIdWithCategoryId(String userId, String? categoryId,
      Function(String) onDataFetched, Function(String) onError) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where("userId", isEqualTo: userId)
          .where("categoryId", isEqualTo: categoryId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String budgetId = querySnapshot.docs[0]['budgetId'];
        onDataFetched(budgetId);
      } else {
        onError("Document not found!");
      }
    } catch (error) {
      onError("Error: $error");
    }
  }

  Future<void> updateSpentAmount(String budgetId, double amount) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('budgets').doc(budgetId).get();

      if (userSnapshot.exists) {
        double expenseCap = userSnapshot.data()!['expenseCap'];
        if (expenseCap != 0) {
          double currentSpentAmount =
              (userSnapshot.data()!['spentAmount'] as num).toDouble();
          double newSpentAmout = currentSpentAmount + amount;

          await _firestore.collection('budgets').doc(budgetId).update({
            'spentAmount': newSpentAmout,
          });
        }
      } else {
        throw 'Budget not found';
      }
    } catch (error) {
      throw "Error updating budget's spent amount: $error";
    }
  }

  Future<void> deleteBudget(String? categoryId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('budgets')
          .where("categoryId", isEqualTo: categoryId)
          .get();
      print("không tìm thấy document cần xóa với categoryId: " + categoryId!);
      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        print("tìm thấy document cần xóa với id: " + documentId);
        await FirebaseFirestore.instance
            .collection('budgets')
            .doc(documentId)
            .delete();
        print('Budget deleted successfully');
      } else {
        print('No matching document found to delete.');
      }
    } catch (error) {
      print('Error deleting Budget: $error');
      throw 'Error deleting Budget: $error';
    }
  }
}
