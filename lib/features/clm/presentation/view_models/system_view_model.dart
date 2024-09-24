import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/system.dart';
import 'package:fwp/features/clm/domain/use_cases/get_systems_use_case.dart';

class SystemViewModel extends ChangeNotifier {
  final GetSystemsUseCase fetchSystemsUseCase;

  List<System> systems = [];
  bool isLoading = false;
  String? errorMessage;

  SystemViewModel(this.fetchSystemsUseCase);

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
}
