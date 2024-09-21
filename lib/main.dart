import 'package:flutter/material.dart';
import 'package:fwp/providers.dart';
import 'package:fwp/routes.dart';
import 'package:fwp/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ...AppProvider.coreProviders,
        ...AppProvider.repositoryProviders,
        ...AppProvider.useCaseProviders,
        ...AppProvider.viewModelProviders
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
      theme: buildTheme(), // Use the custom theme
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
