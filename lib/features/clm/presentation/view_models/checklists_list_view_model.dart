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

    // Print logging for fetch request
    print(
        'Fetching checklists for systemId: $systemId, locationId: $locationId, date: $date');

    try {
      checklists =
          await getChecklistUseCase.getChecklists(systemId, locationId, date);
      // Print the number of checklists fetched
      print('Fetched ${checklists.length} checklists.');
    } catch (e) {
      errorMessage = 'Failed to load checklists';
      // Print the error message
      print('Error fetching checklists: $e');
    } finally {
      isLoading = false;
      notifyListeners();
      // Print when fetching is finished
      print('Finished fetching checklists.');
    }
  }

  // Function to reset the checklists and state
  void resetChecklists() {
    print('Resetting checklists and state.');
    checklists.clear(); // Clear the list of checklists
    isLoading = false; // Reset loading state
    errorMessage = null; // Clear any error messages
    notifyListeners(); // Notify listeners to update the UI
  }
}
