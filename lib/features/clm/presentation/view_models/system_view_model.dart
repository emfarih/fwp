import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/system.dart';
import 'package:fwp/features/clm/domain/use_cases/fetch_systems_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_count_use_case.dart';

class SystemViewModel extends ChangeNotifier {
  final FetchSystemsUseCase fetchSystemsUseCase;
  final GetLocationTypesCountUseCase getLocationTypesCountUseCase;

  List<System> systems = [];
  bool isLoading = false;
  String? errorMessage;

  SystemViewModel(this.fetchSystemsUseCase, this.getLocationTypesCountUseCase);

  Future<void> fetchSystems() async {
    isLoading = true;
    notifyListeners();

    try {
      systems = await fetchSystemsUseCase.execute();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load systems';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> getLocationTypesCount(int systemId) async {
    return await getLocationTypesCountUseCase.execute(systemId);
  }
}
