import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';

class ChecklistTemplateDetailViewModel extends ChangeNotifier {
  ChecklistTemplate? _selectedChecklistTemplate;
  ChecklistTemplate? get selectedChecklistTemplate =>
      _selectedChecklistTemplate;

  void setSelectedChecklistTemplate(ChecklistTemplate checklistTemplate) {
    _selectedChecklistTemplate = checklistTemplate;
    notifyListeners();
  }
}
