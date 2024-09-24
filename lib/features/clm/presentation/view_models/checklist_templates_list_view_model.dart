import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_templates_use_case.dart';

class ChecklistTemplatesListViewModel extends ChangeNotifier {
  final GetChecklistTemplatesUseCase getChecklistTemplatesUseCase;

  ChecklistTemplatesListViewModel(this.getChecklistTemplatesUseCase);

  List<ChecklistTemplate> _checklistTemplates = [];
  List<ChecklistTemplate> get checklistTemplates => _checklistTemplates;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLastPage = false; // Track if the last page has been reached
  bool get isLastPage => _isLastPage;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _limit = 10; // Number of templates to fetch each time
  int _offset = 0; // Current offset for pagination

  Future<void> fetchChecklistTemplates({int limit = 10, int offset = 0}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch templates from the use case with limit and offset
      final templates = await getChecklistTemplatesUseCase.call(limit, offset);

      if (templates.isNotEmpty) {
        _checklistTemplates
            .addAll(templates); // Append new templates to the existing list
        _offset += templates.length; // Update the offset
        _isLastPage =
            templates.length < limit; // Check if this was the last page
      } else {
        _isLastPage = true; // No more templates to fetch
      }

      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreChecklistTemplates() async {
    if (!_isLastPage) {
      await fetchChecklistTemplates(limit: _limit, offset: _offset);
    }
  }

  void reset() {
    _checklistTemplates.clear(); // Clear the list of templates
    _offset = 0; // Reset the offset
    _isLastPage = false; // Reset last page tracking
    notifyListeners(); // Notify listeners to update UI
  }
}
