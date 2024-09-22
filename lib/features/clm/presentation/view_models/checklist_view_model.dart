import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_use_case.dart';
import '../../domain/use_cases/get_checklist_use_case.dart';

class ChecklistViewModel extends ChangeNotifier {
  final GetChecklistUseCase getChecklistUseCase;
  final AddChecklistUseCase _addChecklistUseCase;

  List<Checklist> checklists = [];
  Checklist? selectedChecklist;
  bool isLoading = false;
  String? errorMessage;

  List<ChecklistItem> checklistItems = [];

  String description = "";

  ChecklistViewModel(this.getChecklistUseCase, this._addChecklistUseCase);

  Future<void> fetchChecklists(
      {int? systemId, int? stationId, int? substationId}) async {
    print('fetchChecklists: Start fetching checklists');
    isLoading = true;
    errorMessage = null; // Reset error message on new fetch
    notifyListeners();

    try {
      print('fetchChecklists: Calling execute()');
      var fetchedChecklists = await getChecklistUseCase.execute(
        systemId: systemId,
        stationId: stationId,
        substationId: substationId,
      );

      checklists = List<Checklist>.from(fetchedChecklists);
      print(
          'fetchChecklists: Successfully fetched ${checklists.length} checklists');
    } catch (e) {
      errorMessage = 'Failed to load checklists: $e'; // Include error details
      print('fetchChecklists: Error occurred: $e');
    } finally {
      isLoading = false;
      print('fetchChecklists: Finished fetching checklists');
      notifyListeners();
    }
  }

  Future<void> fetchChecklistById(int id) async {
    print('fetchChecklistById: Start fetching checklist with ID $id');
    isLoading = true;
    notifyListeners();

    try {
      print('fetchChecklistById: Calling executeById() with ID $id');
      selectedChecklist = await getChecklistUseCase.executeById(id);
      print('fetchChecklistById: Successfully fetched checklist with ID $id');
    } catch (e) {
      errorMessage = 'Failed to load checklist';
      print('fetchChecklistById: Error occurred: $e');
    } finally {
      isLoading = false;
      print('fetchChecklistById: Finished fetching checklist with ID $id');
      notifyListeners();
    }
  }

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
