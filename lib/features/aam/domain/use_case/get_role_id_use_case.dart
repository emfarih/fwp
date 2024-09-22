import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class GetRoleIdUseCase {
  final TokenStorageService tokenStorageService;

  GetRoleIdUseCase(this.tokenStorageService);

  Future<int?> getRoleId() async {
    print('GetRoleIdUseCase: Fetching token from TokenStorageService');
    final token = await tokenStorageService.getToken();

    if (token != null) {
      print('GetRoleIdUseCase: Token retrieved successfully');

      // Check if the token is expired
      if (JwtDecoder.isExpired(token)) {
        print('GetRoleIdUseCase: Token is expired');
        tokenStorageService.clearToken();
        return null; // Token is expired
      }

      print('GetRoleIdUseCase: Token is valid, decoding...');

      // Decode the token and extract the role ID
      final decodedToken = JwtDecoder.decode(token);
      final roleId = decodedToken['role_id'] as int?;

      print('GetRoleIdUseCase: Decoded token, role_id = $roleId');
      return roleId;
    }

    print('GetRoleIdUseCase: No token found');
    return null; // Token is not available
  }
}
