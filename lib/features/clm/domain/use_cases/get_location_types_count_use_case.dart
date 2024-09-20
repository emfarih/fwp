import 'package:fwp/features/clm/data/repositories/system_repository.dart';

class GetLocationTypesCountUseCase {
  final SystemRepository systemRepository;

  GetLocationTypesCountUseCase(this.systemRepository);

  Future<int> execute(int systemId) async {
    return await systemRepository.getLocationTypesCount(systemId);
  }
}
