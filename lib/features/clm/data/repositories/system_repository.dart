import 'dart:convert';
import 'package:fwp/features/clm/data/models/system.dart';
import 'package:fwp/shared/services/api_service.dart';

class SystemRepository {
  final ApiService apiService;

  SystemRepository(this.apiService);

  Future<List<System>> fetchSystems() async {
    print('SystemRepository: Start fetching systems');
    try {
      final response = await apiService
          .get('/clm/systems'); // Adjusted the endpoint if necessary
      print(
          'SystemRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        // Directly decode the response body as a list
        final List<dynamic> systemsData = jsonDecode(response.body);

        print(
            'SystemRepository: Successfully parsed ${systemsData.length} systems');
        return systemsData.map((item) => System.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load systems, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('SystemRepository: Error occurred while fetching systems: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }

  Future<int> getLocationTypesCount(int systemId) async {
    final response = await apiService.get('/systems/$systemId/location_types');
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> locationTypes = jsonData['location_types'];
      return locationTypes.length;
    } else {
      throw Exception('Failed to fetch location types for system $systemId');
    }
  }
}
