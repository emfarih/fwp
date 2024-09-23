import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_use_case.dart';

class ChecklistAddViewModel extends ChangeNotifier {
  final AddChecklistUseCase _addChecklistUseCase;

  List<ChecklistItem> checklistItems = [];

  String description = "";

  ChecklistAddViewModel(this._addChecklistUseCase);

  Future<bool> submitChecklist(Checklist checklist) async {
    final finalChecklist = checklist;
    finalChecklist.checklistItems = checklistItems;
    finalChecklist.description = description;
    return await _addChecklistUseCase.execute(finalChecklist);
  }

  void addChecklistItem(ChecklistItem item) {
    checklistItems.add(item);
    notifyListeners(); // Notify listeners to update the UI
  }

  void updateChecklistItemStatus(int itemId, String? status) {
    final item = checklistItems.firstWhere((item) => item.id == itemId);
    item.status = status; // Update the status
    notifyListeners(); // Notify listeners to update the UI
  }
}
