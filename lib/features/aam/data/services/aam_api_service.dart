import 'package:http/http.dart' as http;

class AAMApiService {
  // final String baseUrl = "http://141.11.25.61/aam";
  final String baseUrl = "http://localhost/aam";

  // Perform HTTP POST request
  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }
}
