import 'dart:convert';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/shared/services/api_service.dart';

class ChecklistRepository {
  final ApiService apiService;

  ChecklistRepository(this.apiService);

  // Fetch checklists based on optional query parameters
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

  // Fetch a checklist by its ID
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

  // Create a new checklist
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

  // Update an existing checklist
  Future<bool> updateChecklist(Checklist checklist) async {
    print(
        'ChecklistRepository: Start updating checklist with ID ${checklist.id}');
    try {
      final response = await apiService.put(
        '/clm/checklists/${checklist.id}',
        checklist.toJson(),
      );
      if (response.statusCode == 200) {
        print('ChecklistRepository: Successfully updated checklist');
        return true;
      } else {
        throw Exception(
            'Failed to update checklist, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('ChecklistRepository: Error occurred while updating checklist: $e');
      rethrow;
    }
  }

  // Fetch checklist templates
  Future<List<ChecklistTemplate>> getChecklistTemplates(
      int limit, int offset) async {
    print(
        'ChecklistRepository: Start fetching checklist templates with limit: $limit and offset: $offset');
    try {
      // Include limit and offset in the API request
      final response = await apiService
          .get('/clm/checklist_templates?limit=$limit&offset=$offset');

      print(
          'ChecklistRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> templatesData = jsonData['checklist_templates'];

        print(
            'ChecklistRepository: Raw checklist templates data: $templatesData');

        if (templatesData is! List) {
          throw Exception('Invalid data format: Expected a list');
        }

        List<ChecklistTemplate> parsedTemplates = [];
        for (var item in templatesData) {
          print('ChecklistRepository: Checking item: $item');
          if (item is Map<String, dynamic>) {
            parsedTemplates.add(ChecklistTemplate.fromJson(item));
          } else {
            print('ChecklistRepository: Invalid item: $item');
          }
        }

        print(
            'ChecklistRepository: Successfully parsed ${parsedTemplates.length} checklist templates');
        return parsedTemplates;
      } else {
        throw Exception(
            'Failed to load checklist templates, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'ChecklistRepository: Error occurred while fetching checklist templates: $e');
      rethrow;
    }
  }

  Future<bool> createChecklistTemplate(ChecklistTemplate template) async {
    try {
      print(
          'Attempting to create checklist template: ${template.toJson()}'); // Log the template being created

      final response = await apiService.post(
        '/clm/checklist_templates',
        body: jsonEncode(template
            .toJson()), // Make sure to implement the toJson method in ChecklistTemplate
      );

      print(
          'Received response: ${response.statusCode}'); // Log the status code of the response

      if (response.statusCode == 201) {
        print('Checklist template created successfully.');
        return true;
      } else {
        print(
            'Failed to create checklist template, status code: ${response.statusCode}');
        throw Exception(
            'Failed to create checklist template, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while creating checklist template: $e');
      rethrow;
    }
  }
}
