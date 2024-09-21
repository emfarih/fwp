import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class SystemListScreen extends StatelessWidget {
  const SystemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SystemViewModel>(context);

    print('SystemListScreen: Building UI');

    return Scaffold(
      appBar: AppBar(title: const Text('Systems')),
      body: FutureBuilder<void>(
        future: viewModel.fetchSystems(),
        builder: (context, snapshot) {
          print(
              'SystemListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (viewModel.isLoading) {
            print('SystemListScreen: Loading systems...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'SystemListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print(
              'SystemListScreen: Successfully loaded ${viewModel.systems.length} systems');

          return ListView.builder(
            itemCount: viewModel.systems.length,
            itemBuilder: (context, index) {
              final system = viewModel.systems[index];
              print('SystemListScreen: Displaying system: ${system.fullName}');
              return CLMListTile(
                title: system.fullName,
                subtitle: system.shortName,
                onTap: () async {
                  try {
                    final locationTypesCount =
                        await viewModel.getLocationTypesCount(system.id);

                    // Navigate based on the count of location types
                    if (locationTypesCount > 1) {
                      print(
                          'SystemListScreen: Multiple location types for ${system.fullName}');
                      Navigator.pushNamed(context, AppRoutes.locationTypesList,
                          arguments: system.id);
                    } else {
                      print(
                          'SystemListScreen: Single location type for ${system.fullName}');
                      Navigator.pushNamed(context, AppRoutes.stationsList,
                          arguments: system.id);
                    }
                  } catch (e) {
                    print(
                        'SystemListScreen: Error checking location types: $e');
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
