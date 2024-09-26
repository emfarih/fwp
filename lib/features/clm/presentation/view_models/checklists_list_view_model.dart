import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_use_case.dart';

class ChecklistListViewModel extends ChangeNotifier {
  final GetChecklistUseCase getChecklistUseCase;
  List<Checklist> checklists = [];
  bool isLoading = false;
  String? errorMessage;

  ChecklistListViewModel(this.getChecklistUseCase);

  Future<void> fetchChecklists(
      int systemId, int locationId, DateTime date) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      checklists =
          await getChecklistUseCase.getChecklists(systemId, locationId, date);
    } catch (e) {
      errorMessage = 'Failed to load checklists';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
