import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/location.dart';
import 'package:fwp/features/clm/domain/use_cases/get_locations_use_case.dart';

class LocationsListViewModel extends ChangeNotifier {
  final GetLocationsUseCase getLocationsUseCase;

  List<Location> locations = [];
  String? errorMessage;
  bool isLoading = false;

  LocationsListViewModel(this.getLocationsUseCase);

  Future<void> fetchLocations() async {
    isLoading = true;
    notifyListeners();
    try {
      locations = await getLocationsUseCase.call();
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      locations = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
