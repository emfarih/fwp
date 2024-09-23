import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import '../../domain/use_cases/get_checklist_use_case.dart';

class ChecklistListViewModel extends ChangeNotifier {
  final GetChecklistUseCase getChecklistUseCase;

  List<Checklist> checklists = [];
  bool isLoading = false;
  String? errorMessage;

  ChecklistListViewModel(this.getChecklistUseCase);

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
}
