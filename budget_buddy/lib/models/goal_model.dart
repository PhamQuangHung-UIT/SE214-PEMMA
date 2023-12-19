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

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'goalId': goalId,
      'name': name,
      'imagePath': imagePath,
      'goalAmount': goalAmount,
      'fundAmount': fundAmount,
      'dateEnd': dateEnd,
      // Các trường dữ liệu khác nếu có
    };
  }

  Goal.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        goalId = map['goalId'],
        name = map['name'],
        imagePath = map['imagePath'],
        goalAmount =
            (map['goalAmount'] ?? 0).toDouble(), // Chuyển đổi sang double
        fundAmount =
            (map['fundAmount'] ?? 0).toDouble(), // Chuyển đổi sang double
        dateEnd = map['dateEnd'];
}
