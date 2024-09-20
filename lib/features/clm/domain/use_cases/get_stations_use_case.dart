import 'package:fwp/features/clm/data/repositories/station_repository.dart';
import 'package:fwp/features/clm/data/models/station.dart';

class GetStationsUseCase {
  final StationRepository repository;

  GetStationsUseCase(this.repository);

  Future<List<Station>> execute() async {
    return await repository.fetchStations();
  }
}
