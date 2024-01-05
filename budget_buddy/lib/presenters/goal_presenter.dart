import 'package:budget_buddy/data_sources/repositories/goal_repository.dart';
import 'package:budget_buddy/models/goal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<DocumentSnapshot<Map<String, dynamic>>?> fetchGoalData(
      String goalId) async {
    try {
      return await _repository.fetchGoalData(goalId);
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteGoal(String goalId) async {
    try {
      await _repository.deleteGoal(goalId);
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateGoalFundAmount(String goalId, double fundAmount) async {
    try {
      await _repository.updateGoalFundAmount(goalId, fundAmount);
    } catch (error) {
      throw error;
    }
  }
}
