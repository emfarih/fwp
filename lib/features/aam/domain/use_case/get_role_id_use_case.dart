import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class GetRoleIdUseCase {
  final TokenStorageService tokenStorageService;

  GetRoleIdUseCase(this.tokenStorageService);

  Future<int?> getRoleId() async {
    final token = await tokenStorageService.getToken();
    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['role_id'] as int?;
    }
    return null;
  }
}
