import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:http/http.dart' as http;

class CLMApiService {
  // final String baseUrl = "http://141.11.25.61/clm";
  final String baseUrl = "http://localhost/clm";
  final TokenStorageService tokenStorageService;

  CLMApiService(this.tokenStorageService);

  // Helper function to get headers including the token
  Future<Map<String, String>> _getHeaders() async {
    final token = await tokenStorageService
        .getToken(); // Get the token from the TokenStorageService
    final headers = {
      'Content-Type': 'application/json',
      if (token != null)
        'Authorization': 'Bearer $token', // Include the token if available
    };
    print('CLMApiService: Headers prepared: $headers');
    return headers;
  }

  // GET request with token in headers
  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('CLMApiService: Sending GET request to $uri');
    final headers = await _getHeaders();
    final response = await http.get(uri, headers: headers);
    print(
        'CLMApiService: Received GET response with status code ${response.statusCode}');
    print('CLMApiService: Response body: ${response.body}');
    return response;
  }

  // POST request with token in headers
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('CLMApiService: Sending POST request to $uri');
    final headers = await _getHeaders();
    print('CLMApiService: Request body: $body');
    final response = await http.post(uri, headers: headers, body: body);
    print(
        'CLMApiService: Received POST response with status code ${response.statusCode}');
    print('CLMApiService: Response body: ${response.body}');
    return response;
  }

  // Example PUT request with token in headers
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('CLMApiService: Sending PUT request to $uri');
    final headers = await _getHeaders();
    print('CLMApiService: Request body: $body');
    final response = await http.put(uri, headers: headers, body: body);
    print(
        'CLMApiService: Received PUT response with status code ${response.statusCode}');
    print('CLMApiService: Response body: ${response.body}');
    return response;
  }

  // Example DELETE request with token in headers
  Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('CLMApiService: Sending DELETE request to $uri');
    final headers = await _getHeaders();
    final response = await http.delete(uri, headers: headers);
    print(
        'CLMApiService: Received DELETE response with status code ${response.statusCode}');
    print('CLMApiService: Response body: ${response.body}');
    return response;
  }
}
