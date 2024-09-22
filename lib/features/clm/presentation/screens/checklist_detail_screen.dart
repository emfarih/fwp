import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_view_model.dart'; // Import the ViewModel
import 'package:fwp/features/clm/presentation/widgets/checklist_item_tile.dart'; // Custom ListTile widget

class ChecklistDetailScreen extends StatelessWidget {
  const ChecklistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('ChecklistDetailScreen: Building ChecklistDetailScreen');

    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Details')),
      body: Consumer<ChecklistViewModel>(
        builder: (context, viewModel, child) {
          print(
              'ChecklistDetailScreen: ViewModel loading state: ${viewModel.isLoading}');

          if (viewModel.isLoading) {
            print('ChecklistDetailScreen: Loading checklist data...');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print(
                'ChecklistDetailScreen: Error occurred: ${viewModel.errorMessage}');
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          }

          final selectedChecklist = viewModel.selectedChecklist;

          if (selectedChecklist == null) {
            print('ChecklistDetailScreen: No checklist data found.');
            return const Center(child: Text('No data found.'));
          }

          print(
              'ChecklistDetailScreen: Successfully retrieved checklist with ${selectedChecklist.checklistItems?.length} items.');

          // Log each checklist item
          for (var item in selectedChecklist.checklistItems ?? []) {
            print(
                'ChecklistDetailScreen: Item ID: ${item.id}, Description: ${item.description}, Status: ${item.status}');
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${selectedChecklist.stationId ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.titleLarge),
                Text('Date: ${selectedChecklist.date?.toLocal() ?? 'Unknown'}'),
                const SizedBox(height: 16),
                Text('Checklist Items:',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedChecklist.checklistItems?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = selectedChecklist.checklistItems?[index];
                      if (item == null) {
                        print(
                            'ChecklistDetailScreen: Item is null at index $index');
                        return const SizedBox(); // Return an empty box if item is null
                      }
                      print(
                          'ChecklistDetailScreen: Building item tile for item ID: ${item.id}');
                      return ChecklistItemTile(
                          item: item, viewModel: viewModel);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
