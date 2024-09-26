import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/checklist_item_tile.dart'; // Custom ListTile widget
import 'package:fwp/features/clm/presentation/view_models/checklist_detail_view_model.dart';

class ChecklistDetailScreen extends StatefulWidget {
  const ChecklistDetailScreen({super.key});

  @override
  _ChecklistDetailScreenState createState() => _ChecklistDetailScreenState();
}

class _ChecklistDetailScreenState extends State<ChecklistDetailScreen> {
  late TextEditingController inspectorController;

  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<ChecklistDetailViewModel>(context, listen: false);

    // Initialize the inspector name controller with the view model data
    inspectorController =
        TextEditingController(text: viewModel.selectedChecklist?.inspectorName);
    print(
        'ChecklistDetailScreen: Initialized with inspector: ${inspectorController.text}');
  }

  @override
  void dispose() {
    inspectorController.dispose();
    super.dispose();
    print('ChecklistDetailScreen: Disposed controllers.');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('ChecklistDetailScreen: Building ChecklistDetailScreen');

    return Scaffold(
      appBar: AppBar(
        title: Consumer<ChecklistDetailViewModel>(
          builder: (context, viewModel, child) {
            final selectedChecklist = viewModel.selectedChecklist;
            print(
                'ChecklistDetailScreen: AppBar title set to: ${selectedChecklist?.title ?? 'Checklist Details'}');
            return Text(selectedChecklist?.title ?? 'Checklist Details');
          },
        ),
      ),
      body: Consumer<ChecklistDetailViewModel>(
        builder: (context, viewModel, child) {
          final selectedChecklist = viewModel.selectedChecklist;

          if (selectedChecklist == null) {
            print('ChecklistDetailScreen: No checklist data found.');
            return const Center(child: Text('No data found.'));
          }

          print(
              'ChecklistDetailScreen: Successfully retrieved checklist with ${selectedChecklist.checklistItems?.length} ChecklistItems.');

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Unified card for title, date, description, and inspector name
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row for Title and Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedChecklist.title ?? 'No Title',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selectedChecklist.date != null
                                  ? selectedChecklist.date!
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0]
                                  : 'No Date Available',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Description
                        Text(
                          selectedChecklist.description ?? 'No Description',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        // Inspector Name
                        TextField(
                          controller: inspectorController,
                          decoration: InputDecoration(
                            labelText: 'Inspector Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            print(
                                'ChecklistDetailScreen: Inspector name changed to: $value');
                            viewModel.selectedChecklist?.inspectorName = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Checklist items list
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Checklist Items:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              selectedChecklist.checklistItems?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item =
                                selectedChecklist.checklistItems?[index];
                            if (item == null) return const SizedBox();
                            return ChecklistItemTile(
                                checklistItem: item, viewModel: viewModel);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final detailViewModel =
              Provider.of<ChecklistDetailViewModel>(context, listen: false);
          print(
              'ChecklistDetailScreen: Submitting changes for checklist ID: ${detailViewModel.selectedChecklist?.id}');

          final success = await detailViewModel.submitChecklistUpdate();
          if (success) {
            print('ChecklistDetailScreen: Checklist updated successfully.');
            _showSnackbar('Checklist updated successfully.');
          } else {
            print('ChecklistDetailScreen: Failed to update checklist.');
            _showSnackbar('Failed to update checklist.');
          }
        },
        tooltip: 'Submit Changes',
        child: const Icon(Icons.check),
      ),
    );
  }
}
