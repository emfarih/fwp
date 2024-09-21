import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart'; // Import CLMListTile
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import '../view_models/checklist_view_model.dart';

class ChecklistsListScreen extends StatelessWidget {
  const ChecklistsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the Checklist model from the arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    final viewModel = Provider.of<ChecklistViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checklists')),
      body: FutureBuilder<void>(
        future: viewModel.fetchChecklists(),
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            print('Loading checklists...');
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            print('Error fetching checklists: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          print('Fetched ${viewModel.checklists.length} checklists');

          return ListView.builder(
            itemCount: viewModel.checklists.length,
            itemBuilder: (context, index) {
              final checklistItem = viewModel.checklists[index];

              // Concatenated title with system and station/substation names
              final title =
                  '${checklistItem.systemId} - ${checklistItem.stationId ?? checklistItem.substationId ?? "Unknown"}';

              return CLMListTile(
                title: title, // Concatenated title
                subtitle: checklistItem.description ??
                    'No Description', // Use checklist.description for subtitle
                onTap: () {
                  print('Tapped on checklist: $title');
                  // Handle navigation or actions when the checklist tile is tapped
                  Navigator.pushNamed(
                    context,
                    AppRoutes.checklistDetail, // Replace with your detail route
                    arguments: checklistItem,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Navigating to add checklist screen');
          // Pass the checklist as arguments to the checklist_add route
          Navigator.pushNamed(
            context,
            AppRoutes.checklistAdd,
            arguments: checklist,
          );
        }, // Icon for FAB
        tooltip: 'Add Checklist',
        child: const Icon(Icons.add), // Tooltip for accessibility
      ),
    );
  }
}
