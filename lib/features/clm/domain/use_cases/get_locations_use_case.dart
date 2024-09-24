// domain/use_cases/get_locations_use_case.dart
import 'package:fwp/features/clm/data/models/location.dart';
import 'package:fwp/features/clm/data/repositories/location_repository.dart';

class GetLocationsUseCase {
  final LocationRepository locationRepository;

  GetLocationsUseCase(this.locationRepository);

  Future<List<Location>> call() async {
    return await locationRepository.fetchLocations();
  }
}
