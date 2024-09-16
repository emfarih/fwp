import 'package:flutter/foundation.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  String username = '';
  String password = '';

  LoginViewModel(this._loginUseCase);

  Future<bool> login() async {
    bool success = await _loginUseCase.login(username, password);
    // print('_loginUseCase await passed');
    notifyListeners();
    return success;
  }

  Future<void> logout() async {
    await _loginUseCase.logout();
    notifyListeners();
  }
}
