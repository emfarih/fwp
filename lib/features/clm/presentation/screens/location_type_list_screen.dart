import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/location_type_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class LocationTypesListScreen extends StatelessWidget {
  const LocationTypesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationTypeViewModel>(context);

    // Retrieve the systemId from modal route arguments
    final int systemId = ModalRoute.of(context)?.settings.arguments as int;

    print('LocationTypeListScreen: Building UI with systemId: $systemId');

    return Scaffold(
      appBar: AppBar(title: const Text('Location Types')),
      body: FutureBuilder<void>(
        future: viewModel.fetchLocationTypes(systemId),
        builder: (context, snapshot) {
          print(
              'LocationTypeListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (viewModel.isLoading) {
            print('LocationTypeListScreen: Loading location types...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'LocationTypeListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print(
              'LocationTypeListScreen: Successfully loaded ${viewModel.locationTypes.length} location types');

          return ListView.builder(
            itemCount: viewModel.locationTypes.length,
            itemBuilder: (context, index) {
              final locationType = viewModel.locationTypes[index];
              return CLMListTile(
                title: locationType.name,
                onTap: () {
                  print(
                      'LocationTypeListScreen: Tapped on ${locationType.name}');

                  // Determine the route based on the locationType.name
                  if (locationType.name == 'Station') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.stationsList, // Navigate to stations list
                      arguments: locationType, // Pass locationType as argument
                    );
                  } else if (locationType.name == 'Substation') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.substationsList, // Navigate to substations list
                      arguments: locationType, // Pass locationType as argument
                    );
                  } else {
                    print(
                        'LocationTypeListScreen: Unknown location type ${locationType.name}');
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
