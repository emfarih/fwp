import 'package:flutter/material.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_use_case.dart';
import 'package:fwp/features/clm/data/models/location_type.dart';

class LocationTypeViewModel extends ChangeNotifier {
  final GetLocationTypesUseCase getLocationTypesUseCase;

  bool isLoading = false;
  String? errorMessage;
  List<LocationType> locationTypes = [];

  LocationTypeViewModel(this.getLocationTypesUseCase);

  Future<void> fetchLocationTypes(int systemId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      locationTypes = await getLocationTypesUseCase.execute(systemId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
