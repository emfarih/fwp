import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class GetChecklistDatesUseCase {
  final ChecklistRepository _checklistRepository;

  GetChecklistDatesUseCase(this._checklistRepository);

  Future<List<String>> call(int systemId, int locationId) {
    return _checklistRepository.getChecklistDates(systemId, locationId);
  }
}
