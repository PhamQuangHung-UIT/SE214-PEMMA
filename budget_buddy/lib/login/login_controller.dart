import 'package:budget_buddy/login/login_service.dart';
import 'login_service.dart';

class LoginController {
  String? _username = '';
  String? _password = '';

  var service = LoginService();

  set password(String password) {}

  set username(String username) {}

  Future<bool> isFirstTime() async => service.isFirstTime();

  Future<void> removeFirstTimeState() async => service.removeFirstTimeState();
}
