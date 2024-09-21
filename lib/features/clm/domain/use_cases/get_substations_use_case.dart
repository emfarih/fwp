import 'package:fwp/features/clm/data/models/substation.dart';
import 'package:fwp/features/clm/data/repositories/substation_repository.dart';

class GetSubstationsUseCase {
  final SubstationRepository repository;

  GetSubstationsUseCase(this.repository);

  Future<List<Substation>> execute() async {
    return await repository.fetchSubstations();
  }
}
