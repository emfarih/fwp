import 'dart:html' as html;

class TokenStorageService {
  static const String _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    try {
      // Set cookie without flags for simplicity
      html.window.document.cookie = '$_tokenKey=$token; Path=/';
      print('TokenStorageService: Token saved successfully');
    } catch (e) {
      print('TokenStorageService: An error occurred while saving token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final cookies = html.window.document.cookie?.split('; ') ?? [];
      for (var cookie in cookies) {
        final parts = cookie.split('=');
        if (parts.length == 2 && parts[0] == _tokenKey) {
          print('TokenStorageService: Token retrieved');
          return parts[1];
        }
      }
      print('TokenStorageService: Token is null');
      return null;
    } catch (e) {
      print(
          'TokenStorageService: An error occurred while retrieving token: $e');
      return null;
    }
  }

  Future<void> clearToken() async {
    try {
      html.window.document.cookie =
          '$_tokenKey=; expires=Thu, 01 Jan 1970 00:00:00 GMT; Path=/';
      print('TokenStorageService: Token cleared successfully');
    } catch (e) {
      print('TokenStorageService: An error occurred while clearing token: $e');
    }
  }
}
