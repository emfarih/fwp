import 'package:flutter/material.dart';
import 'package:fwp/features/aam/data/services/aam_api_service.dart';
import 'package:fwp/features/aam/domain/use_case/login_use_case.dart';
import 'package:fwp/features/aam/presentation/screen/login_screen.dart';
import 'package:fwp/features/aam/presentation/view_models/login_view_model.dart';
import 'package:fwp/features/clm/data/repositories/clm_repository.dart';
import 'package:fwp/features/clm/data/services/clm_api_service.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_use_case.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_view_model.dart';
import 'package:provider/provider.dart';
import 'features/aam/data/repositories/aam_repository.dart';
import 'features/aam/data/services/token_storage_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AAMApiService>(
            create: (_) => AAMApiService()), // Or however you initialize this
        Provider<TokenStorageService>(create: (_) => TokenStorageService()),
        Provider<AAMRepository>(
          create: (context) =>
              AAMRepository(Provider.of<AAMApiService>(context, listen: false)),
        ),
        Provider<LoginUseCase>(
          create: (context) => LoginUseCase(
            Provider.of<AAMRepository>(context, listen: false),
            Provider.of<TokenStorageService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) =>
              LoginViewModel(Provider.of<LoginUseCase>(context, listen: false)),
        ),
        Provider<CLMApiService>(create: (_) => CLMApiService()),
        Provider<CLMRepository>(
          create: (context) =>
              CLMRepository(Provider.of<CLMApiService>(context, listen: false)),
        ),
        Provider<GetChecklistUseCase>(
          create: (context) => GetChecklistUseCase(
              Provider.of<CLMRepository>(context, listen: false)),
        ),
        ChangeNotifierProvider<ChecklistViewModel>(
          create: (context) => ChecklistViewModel(
              Provider.of<GetChecklistUseCase>(context, listen: false)),
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
      home: LoginScreen(),
    );
  }
}
