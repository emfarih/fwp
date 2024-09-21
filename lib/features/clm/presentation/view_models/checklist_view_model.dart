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

  Checklist? newChecklist;

  ChecklistViewModel(this.getChecklistUseCase, this._addChecklistUseCase);

  Future<void> fetchChecklists() async {
    print('fetchChecklists: Start fetching checklists');
    isLoading = true;
    notifyListeners();

    try {
      print('fetchChecklists: Calling execute()');
      checklists = await getChecklistUseCase.execute();
      print(
          'fetchChecklists: Successfully fetched ${checklists.length} checklists');
    } catch (e) {
      errorMessage = 'Failed to load checklists';
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

  Future<bool> submitChecklist() async {
    return await _addChecklistUseCase.execute(newChecklist!);
  }

  void setChecklist(Checklist checklist) {
    newChecklist = checklist;
  }

  void addChecklistItem(ChecklistItem item) {
    newChecklist!.checklistItems?.add(item);
    notifyListeners(); // Notify listeners to update the UI
  }
}
