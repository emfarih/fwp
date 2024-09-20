import 'package:fwp/features/clm/data/models/station.dart';
import 'dart:convert';

import 'package:fwp/shared/services/api_service.dart';

class StationRepository {
  final ApiService apiService;

  StationRepository(this.apiService);

  Future<List<Station>> fetchStations() async {
    final response = await apiService.get('/clm/stations');
    if (response.statusCode == 200) {
      final List<dynamic> stationsData = jsonDecode(response.body);
      return stationsData.map((item) => Station.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load stations, status code: ${response.statusCode}');
    }
  }
}
