import 'dart:convert';
import 'package:fwp/features/aam/data/services/aam_api_service.dart';

class AAMRepository {
  final AAMApiService apiService;

  AAMRepository(this.apiService);

  Future<String?> authenticate(String username, String password) async {
    final String credentials = '$username:$password';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));

    final response = await apiService.post(
      '/login',
      headers: {
        'Authorization': 'Basic $encodedCredentials',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Extract the Bearer token from the response header
      String? bearerToken =
          response.headers['authorization']?.replaceFirst('Bearer ', '');
      return bearerToken;
    }

    // Return null if authentication fails
    return null;
  }
}
