import 'package:budget_buddy/data_sources/category_model.dart';
import 'package:budget_buddy/data_sources/repositories/report_repository.dart';
import 'package:budget_buddy/models/transaction_model.dart';
import 'package:budget_buddy/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class ReportViewContract {
  void onLoadDataSuccess(List<Transaction> transactionList,
      Map<String, MyCategory> categoryMap, User currentUser);
  void onLoadDataError(FirebaseException exception);
}

class ReportPresenter {
  final _repos = ReportRepository();
  final ReportViewContract _viewContract;

  ReportPresenter(this._viewContract);

  Future<void> loadData() async {
    try {
      var futureTrans = _repos.getTransactions();
      var futureCat = _repos.getCategory();
      var futureUser = _repos.getUserInfo();

      var transactionList = await futureTrans;
      var categoryMap = await futureCat;
      var user = await futureUser;
      _viewContract.onLoadDataSuccess(transactionList, categoryMap, user);
    } on FirebaseException catch (e) {
      _viewContract.onLoadDataError(e);
    }
  }
}
