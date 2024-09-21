import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class SystemsListScreen extends StatelessWidget {
  const SystemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SystemViewModel>(context);

    print('SystemsListScreen: Building UI');

    return Scaffold(
      appBar: AppBar(title: const Text('Systems')),
      body: FutureBuilder<void>(
        future: viewModel.fetchSystems(),
        builder: (context, snapshot) {
          print(
              'SystemsListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (viewModel.isLoading) {
            print('SystemsListScreen: Loading systems...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'SystemsListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print(
              'SystemsListScreen: Successfully loaded ${viewModel.systems.length} systems');

          return ListView.builder(
            itemCount: viewModel.systems.length,
            itemBuilder: (context, index) {
              final system = viewModel.systems[index];
              print('SystemsListScreen: Displaying system: ${system.fullName}');
              return CLMListTile(
                title: system.fullName,
                subtitle: system.shortName,
                onTap: () async {
                  try {
                    final locationTypesCount =
                        await viewModel.getLocationTypesCount(system.id);

                    // Prepare the checklist model with the selected system's ID
                    final checklist = Checklist(
                      id: 0, // Placeholder ID; adjust as needed
                      systemId: system.id,
                      description: null,
                      locationTypeId: 0, // Default or initial value
                      stationId: null, // Adjust as needed
                      substationId: null, // Adjust as needed
                      inspectionDate: null, // Initialize as needed
                      inspectorName: null, // Initialize as needed
                      checklistItems: [], // Initialize as needed
                      photos: [], // Initialize as needed
                    );

                    // Navigate based on the count of location types
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
