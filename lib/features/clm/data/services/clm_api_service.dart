import 'package:http/http.dart' as http;

class CLMApiService {
  final String baseUrl = "http://141.11.25.61/clm";

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse('$baseUrl$endpoint'));
  }

  // Add other HTTP methods (POST, PUT, DELETE) as needed
}
