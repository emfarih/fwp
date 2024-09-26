import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class GetChecklistUseCase {
  final ChecklistRepository checklistRepository;

  GetChecklistUseCase(this.checklistRepository);

  Future<List<Checklist>> getChecklists(
      int systemId, int locationId, DateTime date) async {
    return await checklistRepository.getChecklists(
        systemId: systemId, locationId: locationId, date: date);
  }
}
