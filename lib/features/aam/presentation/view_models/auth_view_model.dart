import 'package:flutter/foundation.dart';
import 'package:fwp/features/aam/domain/use_case/get_role_id_use_case.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthUseCase _authUseCase;
  final GetRoleIdUseCase _getRoleIdUseCase;

  String username = '';
  String password = '';

  AuthViewModel(this._authUseCase, this._getRoleIdUseCase);

  Future<int?> login() async {
    bool success = await _authUseCase.login(username, password);
    if (success) {
      return await _getRoleIdUseCase.getRoleId();
    }
    // print('_loginUseCase await passed');
    notifyListeners();
    return 0;
  }

  Future<void> logout() async {
    await _authUseCase.logout();
    notifyListeners();
  }
}
