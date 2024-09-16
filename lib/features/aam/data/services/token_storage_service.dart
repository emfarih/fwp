import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  final _storage = const FlutterSecureStorage();

  // Save the token securely
  Future<void> saveToken(String token) async {
    print('TokenStorageService: saving Token $token');
    try {
      await _storage.write(key: 'auth_token', value: token);
      print('TokenStorageService: Token $token Saved successfully');
    } catch (e) {
      print('An error occurred while saving the token: $e');
    }
  }

  // Retrieve the token from secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Clear the token (e.g., on logout)
  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
