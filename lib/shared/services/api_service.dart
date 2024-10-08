import 'dart:convert';

import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final String baseUrl = "http://141.11.25.61";
  final String baseUrl = "http://localhost";
  final TokenStorageService tokenStorageService;

  ApiService(this.tokenStorageService);

  // Helper function to get headers including the token
  Future<Map<String, String>> _getHeaders() async {
    final token = await tokenStorageService
        .getToken(); // Get the token from the TokenStorageService
    final headers = {
      'Content-Type': 'application/json',
      if (token != null)
        'Authorization': 'Bearer $token', // Include the token if available
    };
    print('ApiService: Headers prepared: $headers');
    return headers;
  }

  // GET request with token in headers
  Future<http.Response> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    // Construct the full URL with query parameters
    final uri =
        Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
    print('ApiService: Sending GET request to $uri');

    final headers = await _getHeaders();
    final response = await http.get(uri, headers: headers);
    print(
        'ApiService: Received GET response with status code ${response.statusCode}');
    print('ApiService: Response body: ${response.body}');

    return response;
  }

// Perform HTTP POST request
  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

// Perform HTTP POST request
  Future<http.Response> postLogin(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  // Example PUT request with token in headers
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('ApiService: Sending PUT request to $uri');
    final headers = await _getHeaders();
    print('ApiService: Request body: $body');

    // Use jsonEncode to convert the body to a JSON string
    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body), // Ensure the body is a JSON string
    );

    print(
        'ApiService: Received PUT response with status code ${response.statusCode}');
    print('ApiService: Response body: ${response.body}');
    return response;
  }

  // Example DELETE request with token in headers
  Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('ApiService: Sending DELETE request to $uri');
    final headers = await _getHeaders();
    final response = await http.delete(uri, headers: headers);
    print(
        'ApiService: Received DELETE response with status code ${response.statusCode}');
    print('ApiService: Response body: ${response.body}');
    return response;
  }
}
