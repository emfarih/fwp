import 'dart:convert';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/utils.dart';
import 'package:fwp/shared/services/api_service.dart';

class ChecklistRepository {
  final ApiService apiService;

  ChecklistRepository(this.apiService);

  // Fetch checklists based on optional query parameters
  Future<List<Checklist>> getChecklists({
    required int systemId,
    required int locationId,
    required DateTime date,
  }) async {
    print('ChecklistRepository: Start fetching checklists');

    // Prepare the query parameters
    final queryParams = <String, String>{};
    queryParams['system_id'] = systemId.toString();
    if (locationId != null) {
      queryParams['location_id'] = locationId.toString();
    }
    if (date != null) {
      queryParams['date'] =
          formatDateWithTimezone(date); // Format the date to ISO-8601 string
    }

    try {
      // Perform API request with updated query parameters
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

        // Parse the checklists
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

    // Log the JSON representation of the checklist
    final checklistJson = jsonEncode(checklist.toJson());
    print('ChecklistRepository: JSON to be sent: $checklistJson');

    try {
      final response = await apiService.post(
        '/clm/checklists',
        body: checklistJson,
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
      if (response.statusCode == 200 || response.statusCode == 204) {
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

  Future<List<ChecklistTemplate>> getChecklistTemplates({
    int? systemId,
    int? locationId,
    int limit = 10,
    int offset = 0,
  }) async {
    print(
        'ChecklistRepository: Start fetching checklist templates with limit: $limit, offset: $offset, systemId: $systemId, locationId: $locationId');

    try {
      // Build query parameters based on the presence of systemId and locationId
      String query = '/clm/checklist_templates?limit=$limit&offset=$offset';
      if (systemId != null) {
        query += '&system_id=$systemId';
      }
      if (locationId != null) {
        query += '&location_id=$locationId';
      }

      // Make the API request
      final response = await apiService.get(query);

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

        // Parse checklist templates
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

  Future<List<String>> getChecklistDates(int systemId, int locationId,
      {int limit = 10, int offset = 0}) async {
    print(
        'ChecklistDatesRepository: Start fetching checklist dates for systemId: $systemId, locationId: $locationId with limit: $limit and offset: $offset');

    try {
      // Include systemId, locationId, limit, and offset in the API request
      final response = await apiService.get(
          '/clm/checklist_dates?system_id=$systemId&location_id=$locationId&limit=$limit&offset=$offset');

      print(
          'ChecklistDatesRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<String> datesData = jsonData['checklist_dates'];

        print('ChecklistDatesRepository: Raw checklist dates data: $datesData');

        // Extracting checklist dates as a list of strings
        List<String> checklistDates = [];
        for (var item in datesData) {
          print('ChecklistDatesRepository: Checking item: $item');
          // Assuming the date is under the key 'date' in the response
          checklistDates.add(item);
        }

        print(
            'ChecklistDatesRepository: Successfully parsed ${checklistDates.length} checklist dates');
        return checklistDates;
      } else {
        throw Exception(
            'Failed to load checklist dates, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'ChecklistDatesRepository: Error occurred while fetching checklist dates: $e');
      rethrow;
    }
  }
}
