import 'package:budget_buddy/data_sources/repositories/transaction_repository.dart';
import 'package:budget_buddy/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionPresenter {
  final TransactionRepository _repository = TransactionRepository();

  void fetchTransactions(
    String userId,
    Function(List<Transaction>) onTransactionsFetched,
    Function(String) onError,
  ) {
    _repository.fetchTransactions(userId).listen((transactions) {
      onTransactionsFetched(transactions);
    }, onError: (error) {
      onError("Error fetching transactions: $error");
    });
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    try {
      await _repository.deleteTransaction(transaction);
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteTransactionWhenDeleteCategory(String? categoryId) async {
    try {
      await _repository.deleteTransactionWhenDeleteCategory(categoryId);
    } catch (error) {
      throw error;
    }
  }

  void fetchTransactionData(
      String userId,
      String? transactionId,
      Function(double, String, String, String) onDataFetched,
      Function(String) onError) {
    _repository.fetchTransactionData(
        userId, transactionId, onDataFetched, onError);
  }

  Future<void> addTransaction(
    Transaction newTransaction,
    Function() onTransactionAdded,
    Function(String) onError,
  ) async {
    try {
      await _repository.addTransaction(newTransaction);
      onTransactionAdded();
    } catch (e) {
      onError("Error adding transaction: $e");
    }
  }
}
