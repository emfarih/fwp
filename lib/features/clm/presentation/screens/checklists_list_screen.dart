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
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }
          return ListView.builder(
            itemCount: viewModel.checklists.length,
            itemBuilder: (context, index) {
              final checklistItem = viewModel.checklists[index];

              // Concatenated title with system and station/substation names
              final title =
                  '${checklistItem.systemId} - ${checklistItem.stationId ?? checklistItem.substationId}';

              return CLMListTile(
                title: title, // Concatenated title
                subtitle: checklistItem.description ??
                    'No Description', // Use checklist.description for subtitle
                onTap: () {
                  // Handle navigation or actions when the checklist tile is tapped
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Pass the checklist as arguments to the checklist_add route
          // Navigator.pushNamed(
          //   context,
          //   AppRoutes.checklist_add,
          //   arguments: checklist,
          // );
        },
        child: const Icon(Icons.add), // Icon for FAB
        tooltip: 'Add Checklist', // Tooltip for accessibility
      ),
    );
  }
}
