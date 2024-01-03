import 'package:budget_buddy/presenters/budget_presenter.dart';
import 'package:budget_buddy/presenters/category_presenter.dart';
import 'package:budget_buddy/presenters/user_presenter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:budget_buddy/models/transaction_model.dart' as model;

class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CategoryPresenter _categoryPresenter = CategoryPresenter();
  final UserPresenter _userPresenter = UserPresenter();

  Future<void> addTransaction(model.Transaction newTransaction) async {
    try {
      CollectionReference transactionsCollection =
          _firestore.collection('transactions');
      await transactionsCollection
          .doc(newTransaction.transactionId)
          .set(newTransaction.toMap());
      print("Updated transaction successfully with id: " +
          newTransaction.transactionId);
    } catch (e) {
      print("Error updating transaction: $e");
    }
  }

  Future<void> fetchTransactionData(
      String userId,
      String? transactionId,
      Function(double, String, String, String) onDataFetched,
      Function(String) onError) async {
    try {
      FirebaseFirestore.instance
          .collection("transactions")
          .where("userId", isEqualTo: userId)
          .where("transactionId", isEqualTo: transactionId)
          .snapshots()
          .listen((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          double amount = querySnapshot.docs[0]['amount'];
          String date = querySnapshot.docs[0]['date'];
          String time = querySnapshot.docs[0]['time'];
          String note = querySnapshot.docs[0]['note'];

          onDataFetched(amount, date, time, note);
        } else {
          onError("Document not found!");
        }
      }, onError: (error) {
        onError("Error: $error");
      });
    } catch (error) {
      onError("Error: $error");
    }
  }

  Future<void> deleteTransaction(model.Transaction transaction) async {
    _categoryPresenter.fetchCategoryType(
      transaction.userId,
      transaction.categoryId,
      (isIncome) {
        _userPresenter.updateUserBalanceAfterDeletingTransaction(
            transaction.userId, transaction.amount, isIncome);
      },
      (error) {
        print("Error: $error");
      },
    );

    try {
      await FirebaseFirestore.instance
          .collection('transactions')
          .doc(transaction.transactionId)
          .delete();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteTransactionWhenDeleteCategory(String? categoryId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('transactions')
          .where("categoryId", isEqualTo: categoryId)
          .get();

      List<Future<void>> deleteFutures = [];
      querySnapshot.docs.forEach((doc) {
        deleteFutures.add(doc.reference.delete());
      });

      await Future.wait(deleteFutures);
      print('Transaction deleted successfully with categoryId' + categoryId!);
    } catch (error) {
      print('Error deleting documents: $error');
      throw 'Error deleting documents: $error';
    }
  }

  Stream<List<model.Transaction>> fetchTransactions(String userId) {
    try {
      return _firestore
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs.map((doc) {
                return model.Transaction.fromMap(
                    doc.data() as Map<String, dynamic>);
              }).toList());
    } catch (e) {
      print("Error fetching transactions: $e");
      return Stream.empty(); // Trả về Stream rỗng trong trường hợp lỗi
    }
  }
}
