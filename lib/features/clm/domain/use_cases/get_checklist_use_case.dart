import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/repositories/clm_repository.dart';

class GetChecklistUseCase {
  final CLMRepository repository;

  GetChecklistUseCase(this.repository);

  Future<List<Checklist>> execute() async {
    return repository.getChecklists();
  }

  Future<Checklist> executeById(int id) async {
    return repository.getChecklistById(id);
  }
}
