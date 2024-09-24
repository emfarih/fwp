import 'package:flutter/foundation.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/models/location.dart';
import 'package:fwp/features/clm/data/models/system.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_template_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_locations_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_systems_use_case.dart';

class ChecklistTemplateAddViewModel extends ChangeNotifier {
  final AddChecklistTemplateUseCase addChecklistTemplateUseCase;
  final GetSystemsUseCase getSystemsUseCase;
  final GetLocationsUseCase getLocationsUseCase;

  ChecklistTemplateAddViewModel(this.addChecklistTemplateUseCase,
      this.getSystemsUseCase, this.getLocationsUseCase);

  List<System> _systems = [];
  List<System> get systems => _systems;

  List<Location> _locations = [];
  List<Location> get locations => _locations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchSystems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _systems = await getSystemsUseCase.execute();
      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLocations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _locations = await getLocationsUseCase.call();
      _errorMessage = null; // Clear any previous error messages
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addChecklistTemplate(ChecklistTemplate template) async {
    _isLoading = true;
    notifyListeners();

    try {
      await addChecklistTemplateUseCase.call(template);
      return true;
    } catch (error) {
      print(error);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
