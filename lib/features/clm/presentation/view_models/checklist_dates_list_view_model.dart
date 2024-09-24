import 'package:flutter/material.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_dates_use_case.dart';

class ChecklistDatesListViewModel extends ChangeNotifier {
  final GetChecklistDatesUseCase _getChecklistDatesUseCase;

  List<String> checklistDates = [];
  bool isLoading = false;
  String? errorMessage;

  ChecklistDatesListViewModel(this._getChecklistDatesUseCase);

  Future<void> fetchChecklistDates(int systemId, int locationId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      checklistDates =
          await _getChecklistDatesUseCase.call(systemId, locationId);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
