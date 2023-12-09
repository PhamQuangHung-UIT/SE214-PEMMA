import 'package:budget_buddy/data_sources/repositories/goal_repository.dart';
import 'package:budget_buddy/models/goal_model.dart';

class GoalPresenter {
  final GoalRepository _repository = GoalRepository();

  void fetchGoals(
    String userId,
    Function(List<Goal>) onGoalsFetched,
    Function(String) onError,
  ) {
    _repository.fetchGoals(userId).listen((goals) {
      onGoalsFetched(goals);
    }, onError: (error) {
      onError("Error fetching goals: $error");
    });
  }

  Future<void> addGoal(
    Goal newGoal,
    Function() onGoalAdded,
    Function(String) onError,
  ) async {
    try {
      await _repository.addGoal(newGoal);
      onGoalAdded();
    } catch (e) {
      onError("Error adding goal: $e");
    }
  }
}
