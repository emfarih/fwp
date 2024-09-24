// viewmodels/checklist_templates_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_templates_use_case.dart';

class ChecklistTemplatesViewModel extends ChangeNotifier {
  final GetChecklistTemplatesUseCase getChecklistTemplatesUseCase;

  ChecklistTemplatesViewModel(this.getChecklistTemplatesUseCase);

  List<ChecklistTemplate> _checklistTemplates = [];
  List<ChecklistTemplate> get checklistTemplates => _checklistTemplates;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchChecklistTemplates() async {
    _isLoading = true;
    notifyListeners();

    try {
      _checklistTemplates = await getChecklistTemplatesUseCase.call();
      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
