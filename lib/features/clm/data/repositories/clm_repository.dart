import 'dart:convert';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/shared/services/api_service.dart';

class ChecklistRepository {
  final ApiService apiService;

  ChecklistRepository(this.apiService);

  Future<List<Checklist>> getChecklists() async {
    print('CLMRepository: Start fetching checklists');
    try {
      final response = await apiService.get('/clm/checklists');
      print(
          'CLMRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        // First, decode the response body into a Map
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Access the 'checklists' field from the decoded JSON
        final List<dynamic> checklistsData = jsonData['checklists'];

        print(
            'CLMRepository: Successfully parsed ${checklistsData.length} checklists');
        return checklistsData.map((item) => Checklist.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load checklists, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('CLMRepository: Error occurred while fetching checklists: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }

  Future<Checklist> getChecklistById(int id) async {
    print('CLMRepository: Start fetching checklist with ID $id');
    try {
      final response = await apiService.get('/clm/checklists/$id');
      print(
          'CLMRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('CLMRepository: Successfully parsed checklist with ID $id');
        return Checklist.fromJson(data);
      } else {
        throw Exception(
            'Failed to load checklist with ID $id, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'CLMRepository: Error occurred while fetching checklist with ID $id: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }
}
