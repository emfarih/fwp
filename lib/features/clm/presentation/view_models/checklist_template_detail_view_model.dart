import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/domain/use_cases/delete_checklist_template_use_case.dart';

class ChecklistTemplateDetailViewModel extends ChangeNotifier {
  final DeleteChecklistTemplateUseCase deleteChecklistTemplateUseCase;

  ChecklistTemplateDetailViewModel(this.deleteChecklistTemplateUseCase);

  ChecklistTemplate? _selectedChecklistTemplate;
  ChecklistTemplate? get selectedChecklistTemplate =>
      _selectedChecklistTemplate;

  void setSelectedChecklistTemplate(ChecklistTemplate checklistTemplate) {
    _selectedChecklistTemplate = checklistTemplate;
    notifyListeners();
  }

  Future<void> deleteChecklistTemplateById(int templateId) async {
    await deleteChecklistTemplateUseCase.execute(templateId);
    _selectedChecklistTemplate = null; // Clear selected template after deletion
    notifyListeners();
  }
}
