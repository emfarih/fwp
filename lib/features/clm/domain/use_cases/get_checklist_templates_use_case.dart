// usecases/get_checklist_templates_usecase.dart
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class GetChecklistTemplatesUseCase {
  final ChecklistRepository repository;

  GetChecklistTemplatesUseCase(this.repository);

  Future<List<ChecklistTemplate>> call() {
    return repository.getChecklistTemplates();
  }
}
