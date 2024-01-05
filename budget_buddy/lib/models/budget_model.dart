import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  final String userId;
  final String budgetId;
  final String categoryId;
  final double spentAmount;
  final double expenseCap;
  final Timestamp dateStart;
  final Timestamp dateEnd;

  Budget(
      {required this.userId,
      required this.budgetId,
      required this.categoryId,
      required this.spentAmount,
      required this.expenseCap,
      required this.dateStart,
      required this.dateEnd});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'budgetId': budgetId,
      'categoryId': categoryId,
      'spentAmount': spentAmount,
      'expenseCap': expenseCap,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
    };
  }

  Budget.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        budgetId = map['budgetId'],
        categoryId = map['categoryId'],
        spentAmount = (map['spentAmount'] ?? 0).toDouble(),
        expenseCap = (map['expenseCap'] ?? 0).toDouble(),
        dateStart = map['dateStart'],
        dateEnd = map['dateEnd'];
}
