import 'package:cloud_firestore/cloud_firestore.dart';

class Goal {
  final String userId;
  final String goalId;
  final String name;
  final String imagePath;
  final double fundAmount;
  final double goalAmount;
  final Timestamp dateEnd;

  Goal(
      {required this.userId,
      required this.goalId,
      required this.name,
      required this.imagePath,
      required this.goalAmount,
      required this.fundAmount,
      required this.dateEnd});
}
