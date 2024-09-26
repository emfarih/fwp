import 'package:flutter/material.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_templates_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_use_case.dart'; // Import the AddChecklistUseCase
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/checklist_item.dart';

class ChecklistAddViewModel extends ChangeNotifier {
  final GetChecklistTemplatesUseCase getChecklistTemplatesUseCase;
  final AddChecklistUseCase addChecklistUseCase; // Add checklist use case
  DateTime? checklistDate;
  List<ChecklistTemplate> templates = [];
  ChecklistTemplate? selectedTemplate;
  int? systemId; // Hold the systemId
  int? locationId; // Hold the locationId

  ChecklistAddViewModel(
      this.getChecklistTemplatesUseCase, this.addChecklistUseCase);

  // Set the date
  void setDate(DateTime date) {
    checklistDate = date;
    print('Checklist date set to: $checklistDate'); // Logging the date
    notifyListeners();
  }

  // Set the selected checklist template
  void setSelectedTemplate(ChecklistTemplate? template) {
    selectedTemplate = template;
    print(
        'Selected template set to: ${template?.title}'); // Logging the selected template
    notifyListeners();
  }

  // Fetch checklist templates filtered by systemId and locationId
  Future<void> loadChecklistTemplates({
    required int systemId,
    required int locationId,
    int limit = 10,
    int offset = 0,
  }) async {
    this.systemId = systemId; // Store the systemId
    this.locationId = locationId; // Store the locationId
    print(
        'Loading checklist templates for System ID: $systemId, Location ID: $locationId'); // Logging the IDs
    try {
      templates = await getChecklistTemplatesUseCase.call(
        systemId: systemId,
        locationId: locationId,
        limit: limit,
        offset: offset,
      );
      selectedTemplate = templates[0];
      print(
          'Loaded ${templates.length} checklist templates'); // Logging the number of templates loaded
      notifyListeners();
    } catch (e) {
      // Handle error here (e.g., show a Snackbar)
      print('Error loading checklist templates: $e');
    }
  }

  // Generate a checklist from the selected template
  Checklist generateChecklist() {
    if (selectedTemplate != null && checklistDate != null) {
      List<ChecklistItem> checklistItems =
          selectedTemplate!.items.map((templateItem) {
        print(
            'Creating checklist item: ${templateItem.title}'); // Logging the item title
        return ChecklistItem(
          title: templateItem.title,
          description: templateItem.description,
        );
      }).toList();

      print(
          'Generating checklist with title: ${selectedTemplate!.title}, date: $checklistDate'); // Logging the checklist details

      return Checklist(
        systemId: systemId,
        locationId: locationId,
        date: checklistDate,
        title: selectedTemplate!.title,
        description: selectedTemplate!.description,
        checklistItems: checklistItems,
      );
    } else {
      print(
          'Failed to generate checklist: required fields are missing.'); // Logging missing fields
      throw Exception(
          'Cannot generate checklist, required fields are missing.');
    }
  }

  // Save the checklist
  Future<bool> saveChecklist() async {
    try {
      Checklist checklist = generateChecklist();
      print(
          'Saving checklist: $checklist'); // Logging the checklist being saved
      // Call the use case to save the checklist
      final success = await addChecklistUseCase.execute(checklist);
      if (success) {
        print('Checklist saved successfully: $checklist'); // Logging success
        return true; // Indicate success
      } else {
        print('Failed to save checklist'); // Logging failure
        return false; // Indicate failure
      }
    } catch (e) {
      // Handle error (e.g., show a Snackbar)
      print('Error saving checklist: $e'); // Logging error
      return false; // Indicate failure
    }
  }
}
