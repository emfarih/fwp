import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/repositories/clm_repository.dart';

class GetChecklistUseCase {
  final CLMRepository repository;

  GetChecklistUseCase(this.repository);

  Future<List<Checklist>> execute() async {
    print('GetChecklistUseCase: Start fetching checklists');
    try {
      final checklists = await repository.getChecklists();
      print(
          'GetChecklistUseCase: Successfully fetched ${checklists.length} checklists');
      return checklists;
    } catch (e) {
      print(
          'GetChecklistUseCase: Error occurred while fetching checklists: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }

  Future<Checklist> executeById(int id) async {
    print('GetChecklistUseCase: Start fetching checklist with ID $id');
    try {
      final checklist = await repository.getChecklistById(id);
      print('GetChecklistUseCase: Successfully fetched checklist with ID $id');
      return checklist;
    } catch (e) {
      print(
          'GetChecklistUseCase: Error occurred while fetching checklist with ID $id: $e');
      rethrow; // Rethrow to allow further handling if needed
    }
  }
}
