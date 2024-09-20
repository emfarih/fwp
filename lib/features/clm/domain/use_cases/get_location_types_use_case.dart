import 'package:fwp/features/clm/data/repositories/location_type_repository.dart';
import 'package:fwp/features/clm/data/models/location_type.dart';

class GetLocationTypesUseCase {
  final LocationTypeRepository repository;

  GetLocationTypesUseCase(this.repository);

  Future<List<LocationType>> execute(int systemId) async {
    return await repository.fetchLocationTypes(systemId);
  }
}
