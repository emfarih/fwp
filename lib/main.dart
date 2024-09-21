import 'package:flutter/material.dart';
import 'package:fwp/features/aam/data/services/token_storage_service.dart';
import 'package:fwp/features/aam/domain/use_case/get_role_id_use_case.dart';
import 'package:fwp/features/aam/presentation/screen/login_screen.dart';
import 'package:fwp/features/clm/data/repositories/location_type_repository.dart';
import 'package:fwp/features/clm/data/repositories/station_repository.dart';
import 'package:fwp/features/clm/data/repositories/system_repository.dart';
import 'package:fwp/features/clm/domain/use_cases/fetch_systems_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_count_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_location_types_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_stations_use_case.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_detail_screen.dart';
import 'package:fwp/features/clm/presentation/screens/checklist_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/location_type_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/station_list_screen.dart';
import 'package:fwp/features/clm/presentation/screens/system_list_screen.dart';
import 'package:fwp/features/clm/presentation/view_models/location_type_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/station_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/routes.dart';
import 'package:fwp/splash_screen.dart';
import 'package:provider/provider.dart';
import 'features/aam/data/repositories/aam_repository.dart';
import 'features/aam/domain/use_case/login_use_case.dart';
import 'features/aam/presentation/view_models/login_view_model.dart';
import 'shared/services/api_service.dart';
import 'features/clm/data/repositories/clm_repository.dart';
import 'features/clm/domain/use_cases/get_checklist_use_case.dart';
import 'features/clm/presentation/view_models/checklist_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<TokenStorageService>(create: (_) => TokenStorageService()),
        Provider<ApiService>(
            create: (context) => ApiService(
                  Provider.of<TokenStorageService>(context, listen: false),
                )),
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
        Provider<ChecklistRepository>(
          create: (context) => ChecklistRepository(
            Provider.of<ApiService>(context, listen: false),
          ),
        ),
        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
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
        Provider<GetChecklistUseCase>(
          create: (context) => GetChecklistUseCase(
            Provider.of<ChecklistRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(
            Provider.of<LoginUseCase>(context, listen: false),
            Provider.of<GetRoleIdUseCase>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<SystemViewModel>(
          create: (context) => SystemViewModel(
              Provider.of<FetchSystemsUseCase>(context, listen: false),
              Provider.of<GetLocationTypesCountUseCase>(context,
                  listen: false)),
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
        ChangeNotifierProvider<ChecklistViewModel>(
          create: (context) => ChecklistViewModel(
            Provider.of<GetChecklistUseCase>(context, listen: false),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
