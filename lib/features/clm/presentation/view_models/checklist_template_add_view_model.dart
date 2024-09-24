import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/models/checklist_template_item.dart';
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
      this.getSystemsUseCase, this.getLocationsUseCase) {
    fetchSystems();
    fetchLocations();
  }

  // Controllers for title and description
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<ChecklistTemplateItem> checklistTemplateItems = [];

  List<System> _systems = [];
  List<System> get systems => _systems;

  List<Location> _locations = [];
  List<Location> get locations => _locations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _selectedSystemId;
  int? get selectedSystemId => _selectedSystemId;

  int? _selectedLocationId;
  int? get selectedLocationId => _selectedLocationId;

  // Fetch systems
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

  // Fetch locations
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

  // Set selected system ID
  void setSelectedSystemId(int? id) {
    _selectedSystemId = id;
    notifyListeners();
  }

  // Set selected location ID
  void setSelectedLocationId(int? id) {
    _selectedLocationId = id;
    notifyListeners();
  }

  // Add checklist template item
  void addItem(ChecklistTemplateItem item) {
    checklistTemplateItems.add(item);
    notifyListeners();
  }

  // Remove checklist template item
  void removeItem(int index) {
    checklistTemplateItems.removeAt(index);
    notifyListeners();
  }

  // Add checklist template
  Future<bool> addChecklistTemplate(ChecklistTemplate template) async {
    _isLoading = true;
    notifyListeners();

    try {
      template.items = checklistTemplateItems;
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

  // Dispose of controllers
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
