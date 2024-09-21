import 'package:fwp/features/aam/data/repositories/aam_repository.dart';
import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:fwp/features/aam/domain/use_case/get_role_id_use_case.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';
import 'package:fwp/features/aam/presentation/view_models/auth_view_model.dart';
import 'package:fwp/features/clm/data/repositories/checklist_repository.dart';
import 'package:fwp/features/clm/data/repositories/location_type_repository.dart';
import 'package:fwp/features/clm/data/repositories/station_repository.dart';
import 'package:fwp/features/clm/data/repositories/substation_repository.dart';
import 'package:fwp/features/clm/data/repositories/system_repository.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/fetch_systems_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_count_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_stations_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_substations_use_case.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/location_type_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/station_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/substation_view_model.dart';
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
      Provider<StationRepository>(
        create: (context) => StationRepository(
          Provider.of<ApiService>(context, listen: false),
        ),
      ),
      Provider<SubstationRepository>(
        create: (context) => SubstationRepository(
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
      Provider<FetchSystemsUseCase>(
        create: (context) => FetchSystemsUseCase(
          Provider.of<SystemRepository>(context, listen: false),
        ),
      ),
      Provider<GetLocationTypesCountUseCase>(
        create: (context) => GetLocationTypesCountUseCase(
          Provider.of<SystemRepository>(context, listen: false),
        ),
      ),
      Provider<GetLocationTypesUseCase>(
        create: (context) => GetLocationTypesUseCase(
          Provider.of<LocationTypeRepository>(context, listen: false),
        ),
      ),
      Provider<GetStationsUseCase>(
        create: (context) => GetStationsUseCase(
          Provider.of<StationRepository>(context, listen: false),
        ),
      ),
      Provider<GetSubstationsUseCase>(
        create: (context) => GetSubstationsUseCase(
          Provider.of<SubstationRepository>(context, listen: false),
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
      ChangeNotifierProvider<SystemViewModel>(
        create: (context) => SystemViewModel(
            Provider.of<FetchSystemsUseCase>(context, listen: false),
            Provider.of<GetLocationTypesCountUseCase>(context, listen: false)),
      ),
      ChangeNotifierProvider<LocationTypeViewModel>(
        create: (context) => LocationTypeViewModel(
          Provider.of<GetLocationTypesUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<StationViewModel>(
        create: (context) => StationViewModel(
          Provider.of<GetStationsUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<SubstationViewModel>(
        create: (context) => SubstationViewModel(
          Provider.of<GetSubstationsUseCase>(context, listen: false),
        ),
      ),
      ChangeNotifierProvider<ChecklistViewModel>(
        create: (context) => ChecklistViewModel(
          Provider.of<GetChecklistUseCase>(context, listen: false),
          Provider.of<AddChecklistUseCase>(context, listen: false),
        ),
      ),
    ];
  }
}
