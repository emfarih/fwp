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
    isLoading = true;
    notifyListeners();

    try {
      checklists = await getChecklistUseCase.execute();
    } catch (e) {
      errorMessage = 'Failed to load checklists';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchChecklistById(int id) async {
    isLoading = true;
    notifyListeners();

    try {
      selectedChecklist = await getChecklistUseCase.executeById(id);
    } catch (e) {
      errorMessage = 'Failed to load checklist';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
