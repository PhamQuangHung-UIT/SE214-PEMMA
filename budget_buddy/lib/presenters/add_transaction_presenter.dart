import 'package:budget_buddy/data_sources/repositories/add_transaction_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AddTransactionViewContract {
  void onAddNewTransactionSuccess();
  void onAddNewTransactionError(FirebaseException e);
}

class AddTransactionPresenter {
  final _repos = AddTransactionRepository();
  final AddTransactionViewContract _viewContract;

  AddTransactionPresenter(this._viewContract);
}
