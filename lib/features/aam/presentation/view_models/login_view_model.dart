import 'package:flutter/foundation.dart';
import 'package:fwp/features/aam/domain/use_case/get_role_id_use_case.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final GetRoleIdUseCase _getRoleIdUseCase;

  String username = '';
  String password = '';

  LoginViewModel(this._loginUseCase, this._getRoleIdUseCase);

  Future<int?> login() async {
    bool success = await _loginUseCase.login(username, password);
    if (success) {
      return await _getRoleIdUseCase.getRoleId();
    }
    // print('_loginUseCase await passed');
    notifyListeners();
    return 0;
  }

  Future<void> logout() async {
    await _loginUseCase.logout();
    notifyListeners();
  }
}
