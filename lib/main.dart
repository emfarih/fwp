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
    print("Starting FWP version: 0.0.143");
    return MaterialApp(
      title: 'Your App Title',
      navigatorObservers: [MyNavigatorObserver()],
      theme: buildTheme(), // Use the custom theme
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Popped route: ${route.settings.name}');
  }
}
