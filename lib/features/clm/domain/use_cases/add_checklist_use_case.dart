import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class AddChecklistUseCase {
  final ChecklistRepository _repository;

  AddChecklistUseCase(this._repository);

  Future<bool> execute(Checklist checklist) async {
    return await _repository.createChecklist(checklist);
  }
}
