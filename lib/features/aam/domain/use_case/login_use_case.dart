import 'package:fwp/features/aam/data/repositories/aam_repository.dart';
import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginUseCase {
  final AAMRepository repository;
  final TokenStorageService tokenStorageService;

  LoginUseCase(this.repository, this.tokenStorageService);

  Future<bool> login(String username, String password) async {
    final token = await repository.authenticate(username, password);
    print('LoginUseCase: Token $token');

    if (token != null) {
      print(
          'LoginUseCase: saving Token on tokenStorageService $tokenStorageService');
      await tokenStorageService.saveToken(token);
      print(
          'LoginUseCase: Token saved on tokenStorageService $tokenStorageService');

      // Check the role in the token
      final decodedToken = JwtDecoder.decode(token);
      print('LoginUseCase: decodedToken $decodedToken');

      final roleId = decodedToken['role_id'];
      print('LoginUseCase: roleId $roleId');

      // Here you can define which roles are allowed to access CLM list
      if (roleId == 2) {
        // Assuming role 1 is allowed
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    await tokenStorageService.clearToken();
  }
}
