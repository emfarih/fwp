import 'dart:convert';

import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/shared/services/api_service.dart';

class ChecklistTemplateRepository {
  final ApiService apiService;

  ChecklistTemplateRepository(this.apiService);

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

  Future<void> deleteChecklistTemplateById(int templateId) async {
    print(
        'ChecklistRepository: Start deleting checklist template with ID: $templateId');

    try {
      // Build the deletion request
      String query = '/clm/checklist_templates/$templateId';

      // Make the DELETE request
      final response = await apiService.delete(
          query); // Assuming you have a delete method in your ApiService

      print(
          'ChecklistRepository: Received response with status code ${response.statusCode}');

      if (response.statusCode == 200) {
        print(
            'ChecklistRepository: Successfully deleted checklist template with ID: $templateId');
      } else {
        throw Exception(
            'Failed to delete checklist template, status code: ${response.statusCode}');
      }
    } catch (e) {
      print(
          'ChecklistRepository: Error occurred while deleting checklist template: $e');
      rethrow; // Rethrow the error after logging it
    }
  }
}
