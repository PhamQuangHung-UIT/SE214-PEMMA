import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/models/transaction_model.dart';
import 'package:budget_buddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:intl/intl.dart';

class ReportRepository {
  Future<List<Transaction>> getTransactions() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;
    var dateFormat = DateFormat('dd-MM-yy');
    var today = DateTime.now();
    var sevenDayBefore = DateTime(today.year, today.month, today.day)
        .subtract(const Duration(days: 7));

    var transactioSnapshot = await firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .get();
    var result = <Transaction>[];
    for (var element in transactioSnapshot.docs) {
      var date = dateFormat.parse(element.data()['date']);
      if (date.isAfter(sevenDayBefore)) {
        var transaction = Transaction.fromMap(element.data());
        result.add(transaction);
      }
    }
    return result;
  }

  Future<Map<String, MyCategory>> getCategory() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;

    // Get all the categories
    var categorySnapshot = await firestore
        .collection('categories')
        .where("userID", isEqualTo: userId)
        .get();
    var result = {
      for (var item in categorySnapshot.docs)
        item.id: MyCategory.fromSnapshot(item)
    };
    return result;
  }

  Future<User> getUserInfo() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    var userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    var user = User.fromMap(userSnapshot.data()!);
    user.firebaseUser = FirebaseAuth.instance.currentUser;
    return user;
  }
}
