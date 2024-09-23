import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/domain/use_cases/update_checklist_use_case.dart';

class ChecklistDetailViewModel extends ChangeNotifier {
  Checklist? _selectedChecklist;
  final UpdateChecklistUseCase _updateChecklistUseCase;

  ChecklistDetailViewModel(this._updateChecklistUseCase);

  Checklist? get selectedChecklist => _selectedChecklist;

  void setSelectedChecklist(Checklist checklist) {
    _selectedChecklist = checklist;
    notifyListeners();
  }

  void updateChecklistItemStatus(int checklistItemId, String? newStatus) {
    if (_selectedChecklist != null &&
        _selectedChecklist!.checklistItems != null) {
      // Find and update the checklist item by its id
      _selectedChecklist!.checklistItems
          ?.firstWhere((item) => item.id == checklistItemId)
          .status = newStatus;

      // Notify listeners about the change
      notifyListeners();
    }
  }

  Future<bool> submitChecklistUpdate() async {
    if (_selectedChecklist != null) {
      final updated =
          await _updateChecklistUseCase.execute(_selectedChecklist!);
      return updated;
    }
    return false;
  }
}
