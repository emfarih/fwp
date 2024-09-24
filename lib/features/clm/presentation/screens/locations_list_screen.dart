import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/view_models/locations_list_view_model.dart';

class LocationsListScreen extends StatelessWidget {
  const LocationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationsListViewModel>(context);

    // Retrieve the checklist from modal route arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    // Logging the checklist information
    print('LocationsListScreen: Checklist ID: ${checklist.id}');
    print('LocationsListScreen: Fetching locations...');

    return Scaffold(
      appBar: AppBar(title: const Text('Locations')),
      body: FutureBuilder<void>(
        future: viewModel.fetchLocations(),
        builder: (context, snapshot) {
          // Logging the loading state
          if (viewModel.isLoading) {
            print('LocationsListScreen: Loading locations...');
            return const Center(child: CircularProgressIndicator());
          }

          // Logging error messages if any
          if (viewModel.errorMessage != null) {
            print(
                'LocationsListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          // Logging the number of locations fetched
          print(
              'LocationsListScreen: Fetched ${viewModel.locations.length} locations.');

          return ListView.builder(
            itemCount: viewModel.locations.length,
            itemBuilder: (context, index) {
              final location = viewModel.locations[index];

              // Logging the details of each location
              print(
                  'LocationsListScreen: Location ${index + 1}: ${location.fullName} (ID: ${location.id})');

              return CLMListTile(
                title: location.fullName,
                subtitle: location.shortName ?? "",
                onTap: () {
                  checklist.locationId =
                      location.id; // Assuming Checklist has a setter

                  // Logging the selection of a location
                  print(
                      'LocationsListScreen: Location ${location.fullName} selected. Navigating to ChecklistsListScreen.');

                  // Navigate to checklists list screen
                  Navigator.pushNamed(
                    context,
                    AppRoutes.checklistsList,
                    arguments: checklist, // Pass the updated checklist
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
