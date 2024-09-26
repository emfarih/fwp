import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/repositories/checklist_template_repository.dart';

class AddChecklistTemplateUseCase {
  final ChecklistTemplateRepository repository;

  AddChecklistTemplateUseCase(this.repository);

  Future<void> call(ChecklistTemplate template) {
    return repository.createChecklistTemplate(template);
  }
}
