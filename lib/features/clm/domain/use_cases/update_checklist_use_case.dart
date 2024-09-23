import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class UpdateChecklistUseCase {
  final ChecklistRepository _repository;

  UpdateChecklistUseCase(this._repository);

  Future<bool> execute(Checklist checklist) async {
    return _repository.updateChecklist(checklist);
  }
}
