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
    notifyListeners(); // Notify that loading has started

    // Logging the fetch request
    print(
        'ChecklistTemplatesListViewModel: Fetching checklist templates with limit: $limit, offset: $offset');

    try {
      // Fetch templates from the use case
      final templates =
          await getChecklistTemplatesUseCase.call(limit: limit, offset: offset);

      // Handle the result
      if (templates.isNotEmpty) {
        _checklistTemplates.addAll(templates);
        _offset += templates.length;
        _isLastPage =
            templates.length < limit; // Check if this is the last page
        print(
            'ChecklistTemplatesListViewModel: Fetched ${templates.length} templates. Offset: $_offset');
      } else {
        _isLastPage = true; // No more templates to fetch
        print(
            'ChecklistTemplatesListViewModel: No more templates. Marking as last page.');
      }

      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString();
      print(
          'ChecklistTemplatesListViewModel: Error fetching templates: $_errorMessage');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify that loading has finished
      print('ChecklistTemplatesListViewModel: Finished fetching templates.');
    }
  }

  Future<void> fetchMoreChecklistTemplates() async {
    if (!_isLastPage) {
      print(
          'ChecklistTemplatesListViewModel: Fetching more checklist templates...');
      await fetchChecklistTemplates(limit: _limit, offset: _offset);
    } else {
      print(
          'ChecklistTemplatesListViewModel: No more checklist templates to fetch. Already at the last page.');
    }
  }

  void reset() {
    _checklistTemplates.clear(); // Clear the list of templates
    _offset = 0; // Reset the offset
    _isLastPage = false; // Reset last page tracking
    notifyListeners(); // Notify listeners to update UI

    // Log reset action
    print(
        'ChecklistTemplatesListViewModel: Checklist templates reset. Offset set to 0, last page reset.');
  }
}
