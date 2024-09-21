import 'package:fwp/features/aam/data/repositories/aam_repository.dart';
import 'package:fwp/features/aam/data/services/token_storage_service.dart';

class AuthUseCase {
  final AAMRepository repository;
  final TokenStorageService tokenStorageService;

  AuthUseCase(this.repository, this.tokenStorageService);

  Future<bool> login(String username, String password) async {
    final token = await repository.authenticate(username, password);
    if (token != null) {
      await tokenStorageService.saveToken(token);
      return true; // Assume login is successful if a token is returned and saved
    }
    return false;
  }

  Future<void> logout() async {
    tokenStorageService.clearToken();
  }
}
