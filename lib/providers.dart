import 'package:fwp/features/aam/data/repositories/aam_repository.dart';
import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:fwp/features/aam/domain/use_case/get_role_id_use_case.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';
import 'package:fwp/features/aam/presentation/view_models/auth_view_model.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';
import 'package:fwp/features/clm/data/repositories/location_type_repository.dart';
import 'package:fwp/features/clm/data/repositories/location_repository.dart';
import 'package:fwp/features/clm/data/repositories/system_repository.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_template_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_dates_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_locations_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_systems_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_templates_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/update_checklist_use_case.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_add_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_dates_list_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_detail_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_detail_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklists_list_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/locations_list_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/shared/services/api_service.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static get coreProviders {
    return [
      Provider<TokenStorageService>(create: (_) => TokenStorageService()),
      Provider<ApiService>(
          create: (context) => ApiService(
                Provider.of<TokenStorageService>(context, listen: false),
              )),
    ];
  }

  static get repositoryProviders {
    return [
      Provider<AAMRepository>(
        create: (context) => AAMRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
      Provider<SystemRepository>(
        create: (context) => SystemRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
      Provider<LocationTypeRepository>(
        create: (context) => LocationTypeRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
      Provider<LocationRepository>(
        create: (context) => LocationRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
      Provider<ChecklistRepository>(
        create: (context) => ChecklistRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
    ];
  }

  static get useCaseProviders {
    return [
      Provider<AuthUseCase>(
        create: (context) => AuthUseCase(
          Provider.of<AAMRepository>(context, listen: false),
          Provider.of<TokenStorageService>(context, listen: false),
        ),
      ),
      Provider<GetRoleIdUseCase>(
        create: (context) => GetRoleIdUseCase(
          Provider.of<TokenStorageService>(context, listen: false),
        ),
      ),
      Provider<GetChecklistTemplatesUseCase>(
        create: (context) => GetChecklistTemplatesUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
      Provider<AddChecklistTemplateUseCase>(
        create: (context) => AddChecklistTemplateUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
      Provider<GetSystemsUseCase>(
        create: (context) => GetSystemsUseCase(
          Provider.of<SystemRepository>(context, listen: false),
        ),
      ),
      Provider<GetLocationsUseCase>(
        create: (context) => GetLocationsUseCase(
          Provider.of<LocationRepository>(context, listen: false),
        ),
      ),
      Provider<GetChecklistDatesUseCase>(
        create: (context) => GetChecklistDatesUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
      Provider<GetChecklistUseCase>(
        create: (context) => GetChecklistUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
      Provider<AddChecklistUseCase>(
        create: (context) => AddChecklistUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
      Provider<UpdateChecklistUseCase>(
        create: (context) => UpdateChecklistUseCase(
          Provider.of<ChecklistRepository>(context, listen: false),
        ),
      ),
    ];
  }

  static get viewModelProviders {
    return [
      ChangeNotifierProvider<AuthViewModel>(
        create: (context) => AuthViewModel(
          Provider.of<AuthUseCase>(context, listen: false),
          Provider.of<GetRoleIdUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistTemplatesListViewModel>(
        create: (context) => ChecklistTemplatesListViewModel(
          Provider.of<GetChecklistTemplatesUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistTemplateDetailViewModel>(
        create: (context) => ChecklistTemplateDetailViewModel(),
      ),
      ChangeNotifierProvider<SystemViewModel>(
        create: (context) => SystemViewModel(
          Provider.of<GetSystemsUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<LocationsListViewModel>(
        create: (context) => LocationsListViewModel(
          Provider.of<GetLocationsUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistDatesListViewModel>(
        create: (context) => ChecklistDatesListViewModel(
          Provider.of<GetChecklistDatesUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistAddViewModel>(
        create: (context) => ChecklistAddViewModel(
          Provider.of<GetChecklistTemplatesUseCase>(context, listen: false),
          Provider.of<AddChecklistUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistListViewModel>(
        create: (context) => ChecklistListViewModel(
          Provider.of<GetChecklistUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistDetailViewModel>(
        create: (context) => ChecklistDetailViewModel(
          Provider.of<UpdateChecklistUseCase>(context, listen: false),
        ),
      ),
    ];
  }
}
