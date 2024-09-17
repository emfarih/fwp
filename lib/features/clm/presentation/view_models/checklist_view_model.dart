import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import '../../domain/use_cases/get_checklist_use_case.dart';

class ChecklistViewModel extends ChangeNotifier {
  final GetChecklistUseCase getChecklistUseCase;

  List<Checklist> checklists = [];
  Checklist? selectedChecklist;
  bool isLoading = false;
  String? errorMessage;

  ChecklistViewModel(this.getChecklistUseCase);

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
}
