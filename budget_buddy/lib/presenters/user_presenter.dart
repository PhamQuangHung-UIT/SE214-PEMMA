import 'package:budget_buddy/data_sources/repositories/user_repository.dart';
import 'package:budget_buddy/models/user_model.dart';

class UserPresenter {
  final UserRepository _repository = UserRepository();

  void listenUserBalance(
    String userId,
    Function(double) onBalanceReceived,
    Function(String) onError,
  ) {
    _repository.listenUserBalance(userId).listen((balance) {
      onBalanceReceived(balance);
    }, onError: (error) {
      onError("Error listening user's balance: $error");
    });
  }

  void listenUserData(
    String userId,
    Function(User) onUserDataReceived,
    Function(String) onError,
  ) {
    _repository.listenUserData(userId).listen((userData) {
      onUserDataReceived(userData);
    }, onError: (error) {
      onError("Error listening user's data: $error");
    });
  }

  Future<void> updateUserBalance(String userId, double fundAmount) async {
    try {
      await _repository.updateUserBalance(userId, fundAmount);
    } catch (e) {
      throw "Error updating user's balance: $e";
    }
  }
}
