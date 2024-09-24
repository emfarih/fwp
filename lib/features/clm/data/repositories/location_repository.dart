import 'dart:convert';

import 'package:fwp/features/clm/data/models/location.dart';
import 'package:fwp/shared/services/api_service.dart';

class LocationRepository {
  final ApiService apiService;

  LocationRepository(this.apiService);

  Future<List<Location>> fetchLocations() async {
    final response = await apiService.get('/clm/locations');
    if (response.statusCode == 200) {
      final List<dynamic> stationsData = jsonDecode(response.body);
      return stationsData.map((item) => Location.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load stations, status code: ${response.statusCode}');
    }
  }
}
