// usecases/get_checklist_templates_usecase.dart
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';

class GetChecklistTemplatesUseCase {
  final ChecklistRepository repository;

  GetChecklistTemplatesUseCase(this.repository);

  Future<List<ChecklistTemplate>> call({
    int? systemId,
    int? locationId,
    int limit = 10,
    int offset = 0,
  }) {
    // Pass optional systemId, locationId, and pagination parameters to the repository
    return repository.getChecklistTemplates(
      systemId: systemId,
      locationId: locationId,
      limit: limit,
      offset: offset,
    );
  }
}
