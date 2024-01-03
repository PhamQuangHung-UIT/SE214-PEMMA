import 'package:budget_buddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<double> listenUserBalance(String userId) {
    try {
      return _firestore
          .collection("users")
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          double storedBalance =
              (snapshot.docs[0]['balance'] as num).toDouble();
          return storedBalance;
        } else {
          print("Document not found!");
          return 0.0;
        }
      });
    } catch (error) {
      print("Error: $error");
      return Stream.empty();
    }
  }

  Stream<User> listenUserData(String userId) {
    try {
      return _firestore
          .collection("users")
          .where("userId", isEqualTo: userId)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var userData = snapshot.docs.first.data() as Map<String, dynamic>;
          double storedBalance = 0.0;
          String fullName = '';

          dynamic balanceData = userData['balance'];
          dynamic fullNameData = userData['fullname'];

          if (balanceData is num) {
            storedBalance = balanceData.toDouble();
          }

          if (fullNameData is String) {
            fullName = fullNameData;
          }

          return User.onlyNameAndBalance(
            userId: userId,
            fullname: fullName,
            balance: storedBalance,
          );
        } else {
          throw 'No matching document found';
        }
      });
    } catch (error) {
      throw "Error fetching user's data: $error";
    }
  }

  //hàm này để trừ 1 số tiền (fundAmount) vô tài khoản của user
  Future<void> updateUserBalance(String userId, double fundAmount) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection("users").doc(userId).get();

      if (userSnapshot.exists) {
        double currentBalance =
            (userSnapshot.data()!['balance'] as num).toDouble();
        double newBalance = currentBalance - fundAmount;

        await _firestore.collection("users").doc(userId).update({
          'balance': newBalance,
        });
      } else {
        throw 'User not found';
      }
    } catch (error) {
      throw "Error updating user's balance: $error";
    }
  }

  Future<void> updateUserBalanceAfterCreatingTransaction(
      String userId, double amount, bool isIncome) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection("users").doc(userId).get();

      if (userSnapshot.exists) {
        double newBalance;
        double currentBalance =
            (userSnapshot.data()!['balance'] as num).toDouble();
        if (isIncome) {
          //nếu là thu nhập
          newBalance = currentBalance + amount;
        } else {
          // nếu là chi tiêu
          newBalance = currentBalance - amount;
        }
        await _firestore.collection("users").doc(userId).update({
          'balance': newBalance,
        });
      } else {
        throw 'User not found';
      }
    } catch (error) {
      throw "Error updating user's balance after creating a new transaction: $error";
    }
  }

  Future<void> updateUserBalanceAfterDeletingTransaction(
      String userId, double amount, bool isIncome) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection("users").doc(userId).get();

      if (userSnapshot.exists) {
        double newBalance;
        double currentBalance =
            (userSnapshot.data()!['balance'] as num).toDouble();
        if (isIncome) {
          //nếu là thu nhập
          newBalance = currentBalance - amount;
        } else {
          // nếu là chi tiêu
          newBalance = currentBalance + amount;
        }
        await _firestore.collection("users").doc(userId).update({
          'balance': newBalance,
        });
      } else {
        throw 'User not found';
      }
    } catch (error) {
      throw "Error updating user's balance after creating a new transaction: $error";
    }
  }
}
