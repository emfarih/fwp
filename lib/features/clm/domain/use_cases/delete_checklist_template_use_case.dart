import 'package:fwp/features/clm/data/repositories/checklist_template_repository.dart';

class DeleteChecklistTemplateUseCase {
  final ChecklistTemplateRepository repository;

  DeleteChecklistTemplateUseCase(this.repository);

  Future<void> execute(int templateId) async {
    await repository.deleteChecklistTemplateById(templateId);
  }
}
