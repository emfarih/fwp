import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/location_type_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class LocationTypesListScreen extends StatelessWidget {
  const LocationTypesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationTypeViewModel>(context);

    // Retrieve the Checklist from modal route arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    print(
        'LocationTypesListScreen: Building UI with checklist ID: ${checklist.id}');

    return Scaffold(
      appBar: AppBar(title: const Text('Location Types')),
      body: FutureBuilder<void>(
        future: viewModel
            .fetchLocationTypes(checklist.systemId), // Use checklist.systemId
        builder: (context, snapshot) {
          print(
              'LocationTypesListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (viewModel.isLoading) {
            print('LocationTypesListScreen: Loading location types...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'LocationTypesListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print(
              'LocationTypesListScreen: Successfully loaded ${viewModel.locationTypes.length} location types');

          return ListView.builder(
            itemCount: viewModel.locationTypes.length,
            itemBuilder: (context, index) {
              final locationType = viewModel.locationTypes[index];
              return CLMListTile(
                title: locationType.name,
                onTap: () {
                  print(
                      'LocationTypesListScreen: Tapped on ${locationType.name}');

                  // Determine the route based on the locationType.name
                  if (locationType.name == 'Station') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.stationsList, // Navigate to stations list
                      arguments: checklist, // Pass checklist as argument
                    );
                  } else if (locationType.name == 'Substation') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.substationsList, // Navigate to substations list
                      arguments: checklist, // Pass checklist as argument
                    );
                  } else {
                    print(
                        'LocationTypesListScreen: Unknown location type ${locationType.name}');
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
