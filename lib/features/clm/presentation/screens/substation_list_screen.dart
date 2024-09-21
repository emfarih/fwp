import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/location_type.dart';
import 'package:fwp/features/clm/presentation/view_models/substation_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class SubstationsListScreen extends StatelessWidget {
  const SubstationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SubstationViewModel>(context);

    // Retrieve the checklist from modal route arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    print('SubstationsListScreen: Building UI');

    return Scaffold(
      appBar: AppBar(title: const Text('Substations List')),
      body: FutureBuilder<void>(
        future: viewModel.fetchSubstations(),
        builder: (context, snapshot) {
          print(
              'SubstationsListScreen: FutureBuilder state: ${snapshot.connectionState}');

          if (viewModel.isLoading) {
            print('SubstationsListScreen: Loading substations...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'SubstationsListScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print(
              'SubstationsListScreen: Successfully loaded ${viewModel.substations.length} substations');

          return ListView.builder(
            itemCount: viewModel.substations.length,
            itemBuilder: (context, index) {
              final substation = viewModel.substations[index];
              return CLMListTile(
                title: substation.fullName,
                subtitle: substation.shortName,
                onTap: () {
                  print(
                      'SubstationsListScreen: Tapped on ${substation.fullName}');

                  // Update checklist's locationTypeId to the substation's ID
                  checklist.locationTypeId = LocationTypeEnum
                      .substation.id; // Assuming Checklist has a setter
                  // Update checklist's locationTypeId to the substation's ID
                  checklist.substationId =
                      substation.id; // Assuming Checklist has a setter

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
