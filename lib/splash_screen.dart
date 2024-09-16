import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/aam/domain/use_case/get_role_id_use_case.dart';
import 'features/clm/presentation/screens/checklist_list_screen.dart';
import 'features/aam/presentation/screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getRoleIdUseCase =
        Provider.of<GetRoleIdUseCase>(context, listen: false);

    return FutureBuilder<int?>(
      future: getRoleIdUseCase.getRoleId(),
      builder: (context, snapshot) {
        print('SplashScreen: Checking role_id...');

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('SplashScreen: Waiting for role_id data...');
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            final roleId = snapshot.data;
            print('SplashScreen: role_id found - $roleId');

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => roleId == 2
                      ? const ChecklistListScreen()
                      : const LoginScreen(),
                ),
              );
            });
          } else {
            if (snapshot.hasError) {
              print('SplashScreen: Error loading role_id - ${snapshot.error}');
            } else {
              print('SplashScreen: No role_id found.');
            }

            // Navigate to LoginScreen in case of error or null data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            });
          }
        }

        return const SizedBox
            .shrink(); // Return an empty widget while navigating
      },
    );
  }
}
