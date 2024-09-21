import 'package:flutter/material.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import 'features/aam/domain/use_case/get_role_id_use_case.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getRoleIdUseCase =
        Provider.of<GetRoleIdUseCase>(context, listen: false);

    return FutureBuilder<int?>(
      future: getRoleIdUseCase.getRoleId(),
      builder: (context, snapshot) {
        print('build at ${DateTime.now()}');
        print('SplashScreen: Checking role_id...');

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('SplashScreen: Waiting for role_id data...');
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            final roleId = snapshot.data;
            print('SplashScreen: role_id found - $roleId');

            // Navigate based on the role ID using named routes
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (roleId == 2) {
                // Remove the back button by setting the 'system_list' route as the root.
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.systemsList,
                  (Route<dynamic> route) =>
                      false, // Removes all previous routes
                );
              } else {
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }
            });
          } else {
            if (snapshot.hasError) {
              print('SplashScreen: Error loading role_id - ${snapshot.error}');
            } else {
              print('SplashScreen: No role_id found.');
            }

            // Navigate to LoginScreen in case of error or null data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            });
          }
        }

        return const SizedBox
            .shrink(); // Return an empty widget while navigating
      },
    );
  }
}
