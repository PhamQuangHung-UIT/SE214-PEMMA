import 'package:budget_buddy/data_sources/repositories/budget_repository.dart';
import 'package:budget_buddy/models/budget_model.dart';

class BudgetPresenter {
  final BudgetRepository _repository = BudgetRepository();

  void fetchBudgets(
    String userId,
    Function(List<Budget>) onBudgetsFetched,
    Function(String) onError,
  ) {
    _repository.fetchBudgets(userId).listen((budgets) {
      onBudgetsFetched(budgets);
    }, onError: (error) {
      onError("Error fetching budgets: $error");
    });
  }

  Future<void> addBudget(
    Budget newBudget,
    Function() onBudgetAdded,
    Function(String) onError,
  ) async {
    try {
      await _repository.addBudget(newBudget);
      onBudgetAdded();
    } catch (e) {
      onError("Error adding budget: $e");
    }
  }
}
