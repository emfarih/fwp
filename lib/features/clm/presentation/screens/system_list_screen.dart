import 'package:flutter/material.dart';
import 'package:fwp/features/aam/presentation/view_models/auth_view_model.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class SystemsListScreen extends StatelessWidget {
  const SystemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final systemViewModel = Provider.of<SystemViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    print('SystemsListScreen: Building UI');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Systems'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await authViewModel.logout(); // Call the logout method
              Navigator.pushReplacementNamed(
                  context, AppRoutes.login); // Navigate to login
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: systemViewModel.fetchSystems(),
        builder: (context, snapshot) {
          print(
              'SystemsListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (systemViewModel.isLoading) {
            print('SystemsListScreen: Loading systems...');
            return const Center(child: CircularProgressIndicator());
          }

          if (systemViewModel.errorMessage != null) {
            print(
                'SystemsListScreen: Error occurred: ${systemViewModel.errorMessage}');
            return Center(child: Text(systemViewModel.errorMessage!));
          }

          print(
              'SystemsListScreen: Successfully loaded ${systemViewModel.systems.length} systems');

          return ListView.builder(
            itemCount: systemViewModel.systems.length,
            itemBuilder: (context, index) {
              final system = systemViewModel.systems[index];
              print('SystemsListScreen: Displaying system: ${system.fullName}');
              return CLMListTile(
                title: system.fullName,
                subtitle: system.shortName,
                onTap: () async {
                  try {
                    final locationTypesCount =
                        await systemViewModel.getLocationTypesCount(system.id);

                    final checklist = Checklist(systemId: system.id);

                    if (locationTypesCount > 1) {
                      print(
                          'SystemsListScreen: Multiple location types for ${system.fullName}');
                      Navigator.pushNamed(context, AppRoutes.locationTypesList,
                          arguments: checklist);
                    } else {
                      print(
                          'SystemsListScreen: Single location type for ${system.fullName}');
                      Navigator.pushNamed(context, AppRoutes.stationsList,
                          arguments: checklist);
                    }
                  } catch (e) {
                    print(
                        'SystemsListScreen: Error checking location types: $e');
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
