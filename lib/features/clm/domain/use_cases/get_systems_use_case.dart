import 'package:fwp/features/clm/data/models/system.dart';
import 'package:fwp/features/clm/data/repositories/system_repository.dart';

class GetSystemsUseCase {
  final SystemRepository systemRepository;

  GetSystemsUseCase(this.systemRepository);

  Future<List<System>> execute() {
    return systemRepository.fetchSystems();
  }
}
