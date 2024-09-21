import 'dart:convert';

import 'package:fwp/features/clm/data/models/location_type.dart';
import 'package:fwp/shared/services/api_service.dart';

class LocationTypeRepository {
  final ApiService apiService;

  LocationTypeRepository(this.apiService);

  Future<List<LocationType>> fetchLocationTypes(int systemId) async {
    try {
      final response = await apiService.get('/clm/location_types');
      if (response.statusCode == 200) {
        // Decode the response and return a list of location types
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => LocationType.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load location types');
      }
    } catch (e) {
      throw Exception(
          'LocationTypeRepository: Error fetching location types: $e');
    }
  }
}
