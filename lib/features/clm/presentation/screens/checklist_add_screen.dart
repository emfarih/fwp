import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/data/models/checklist_item.dart';
import 'package:fwp/features/clm/presentation/view_models/checklists_list_view_model.dart';
import 'package:provider/provider.dart';

class ChecklistAddScreen extends StatelessWidget {
  const ChecklistAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('ChecklistAddScreen: Building UI');

    final viewModel = Provider.of<ChecklistListViewModel>(context);

    // Retrieve the checklist from the arguments
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    print('ChecklistAddScreen: Retrieved checklist $checklist');

    // Create a title based on systemId, stationId, and substationId
    final title =
        '${checklist.systemId} - ${checklist.stationId ?? checklist.substationId ?? "No Station/Substation"}';

    print('ChecklistAddScreen: Generated title - $title');

    return Scaffold(
      appBar: AppBar(title: Text('Add Checklist - $title')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                print('ChecklistAddScreen: Description changed - $value');
                viewModel.description = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent, // Text color
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Padding for a better look
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () async {
                print(
                    'ChecklistAddScreen: Submitting checklist - ${viewModel.description}');
                if (await viewModel.submitChecklist(checklist)) {
                  print('ChecklistAddScreen: Checklist added successfully');
                  Navigator.pop(context); // Return to the previous screen
                } else {
                  print('ChecklistAddScreen: Failed to add checklist');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add checklist')),
                  );
                }
              },
              child: const Text(
                'Add Checklist',
                style: TextStyle(
                  color: Colors.white, // Ensure text color is white
                  fontSize: 16, // Set font size
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    Colors.redAccent, // Text color when button is pressed
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 12), // Padding for a better look
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () async {
                print('ChecklistAddScreen: Opening Add Item Dialog');
                await _showAddItemDialog(context, viewModel);
              },
              child: const Text(
                'Add Checklist Item',
                style: TextStyle(
                  color: Colors.white, // Ensure text color is white
                  fontSize: 16, // Set font size
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.checklistItems.length,
                itemBuilder: (context, index) {
                  final item = viewModel.checklistItems[index];

                  print(
                      'ChecklistAddScreen: Displaying checklist item - ${item?.description ?? "No Description"}');

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 4, // Add shadow to the card
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      color:
                          Colors.red[50], // Light red background to match theme
                      child: ListTile(
                        leading: Icon(
                          Icons.check_circle_outline,
                          color: Colors.redAccent, // Icon to match the theme
                        ),
                        title: Text(
                          item.description ?? 'No Description',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600, // Bold text for emphasis
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors
                              .redAccent, // Trailing icon color matching theme
                          size: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showAddItemDialog(
      BuildContext context, ChecklistListViewModel viewModel) async {
    final TextEditingController descriptionController = TextEditingController();

    print('_showAddItemDialog: Opening dialog');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Checklist Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (descriptionController.text.isNotEmpty) {
                  final checklistItem =
                      ChecklistItem(description: descriptionController.text);
                  print(
                      '_showAddItemDialog: Adding checklist item - ${checklistItem.description}');
                  viewModel.addChecklistItem(checklistItem);
                  print(
                      '_showAddItemDialog: Checklist item added successfully');
                  Navigator.of(context).pop();
                } else {
                  print(
                      '_showAddItemDialog: Failed to add checklist item - Empty fields');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Add Item'),
            ),
            TextButton(
              onPressed: () {
                print('_showAddItemDialog: Canceled adding checklist item');
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            )
          ],
        );
      },
    );
  }
}
