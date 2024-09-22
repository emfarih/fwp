import 'dart:convert';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/shared/services/api_service.dart';

class ChecklistRepository {
  final ApiService apiService;

  ChecklistRepository(this.apiService);

  Future<List<Checklist>> getChecklists(
      {int? systemId, int? stationId, int? substationId}) async {
    print('ChecklistRepository: Start fetching checklists');

    // Prepare the query parameters
    final queryParams = <String, String>{};
    if (systemId != null) {
      queryParams['system_id'] = systemId.toString();
    }
    if (stationId != null) {
      queryParams['station_id'] = stationId.toString();
    }
    if (substationId != null) {
      queryParams['substation_id'] = substationId.toString();
    }

    try {
      final response =
          await apiService.get('/clm/checklists', queryParams: queryParams);
      print(
          'ChecklistRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> checklistsData = jsonData['checklists'];

        print('ChecklistRepository: Raw checklists data: $checklistsData');

        if (checklistsData is! List) {
          throw Exception('Invalid data format: Expected a list');
        }

        List<Checklist> parsedChecklists = [];
        for (var item in checklistsData) {
          print('ChecklistRepository: Checking item: $item');
          if (item is Map<String, dynamic>) {
            parsedChecklists.add(Checklist.fromJson(item));
          } else {
            print('ChecklistRepository: Invalid item: $item');
          }
        }

        print(
            'ChecklistRepository: Successfully parsed ${parsedChecklists.length} checklists');
        return parsedChecklists;
      } else {
        throw Exception(
            'Failed to load checklists, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'ChecklistRepository: Error occurred while fetching checklists: $e');
      rethrow;
    }
  }

  Future<Checklist> getChecklistById(int id) async {
    print('ChecklistRepository: Start fetching checklist with ID $id');
    try {
      final response = await apiService.get('/clm/checklists/$id');
      print(
          'ChecklistRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('ChecklistRepository: Successfully parsed checklist with ID $id');
        return Checklist.fromJson(data);
      } else {
        throw Exception(
            'Failed to load checklist with ID $id, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'ChecklistRepository: Error occurred while fetching checklist with ID $id: $e');
      rethrow;
    }
  }

  Future<bool> createChecklist(Checklist checklist) async {
    print('ChecklistRepository: Start creating checklist');
    try {
      final response = await apiService.post(
        '/clm/checklists',
        body: jsonEncode(checklist.toJson()),
      );
      print(
          'ChecklistRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 201) {
        print('ChecklistRepository: Successfully created checklist');
        return true;
      } else {
        throw Exception(
            'Failed to create checklist, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('ChecklistRepository: Error occurred while creating checklist: $e');
      rethrow;
    }
  }
}
