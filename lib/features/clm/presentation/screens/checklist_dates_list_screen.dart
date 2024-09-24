import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_dates_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/routes.dart';

class ChecklistDatesListScreen extends StatelessWidget {
  const ChecklistDatesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistDatesListViewModel>(context);

    // Retrieve the checklist from modal route arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    // Logging the checklist information
    print('ChecklistDatesListScreen: Checklist ID: ${checklist.id}');

    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Dates')),
      body: FutureBuilder<void>(
        future: viewModel.fetchChecklistDates(
            checklist.systemId!, checklist.locationId!),
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.checklistDates.isEmpty) {
            return Center(child: const Text('No checklist dates available.'));
          }

          return ListView.builder(
            itemCount: viewModel.checklistDates.length,
            itemBuilder: (context, index) {
              final checklistDate = viewModel.checklistDates[index];

              return CLMListTile(
                title: checklistDate,
                onTap: () {
                  // Handle date selection if needed
                  print(
                      'ChecklistDatesListScreen: Date selected: $checklistDate');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new checklist
          Navigator.pushNamed(context, AppRoutes.checklistAdd);
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Checklist',
      ),
    );
  }
}
