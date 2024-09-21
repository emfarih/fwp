import 'dart:convert';
import 'package:fwp/features/clm/data/models/substation.dart';
import 'package:fwp/shared/services/api_service.dart';

class SubstationRepository {
  final ApiService apiService;

  SubstationRepository(this.apiService);

  Future<List<Substation>> fetchSubstations() async {
    print('SubstationRepository: Start fetching substations');

    try {
      final response = await apiService.get('/clm/substations');
      print(
          'SubstationRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        // Directly decode the response body as a list
        final List<dynamic> substationsData = jsonDecode(response.body);

        print(
            'SubstationRepository: Successfully parsed ${substationsData.length} substations');
        return substationsData
            .map((item) => Substation.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Failed to load substations, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'SubstationRepository: Error occurred while fetching substations: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }
}
