import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/models/checklist_template_item.dart';
import 'package:fwp/features/clm/domain/use_cases/add_checklist_template_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_locations_use_case.dart';
import 'package:fwp/features/clm/domain/use_cases/get_systems_use_case.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_add_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:provider/provider.dart';

class ChecklistTemplateAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('ChecklistTemplateAddScreen: Building UI');

    // Provide ChecklistTemplateAddViewModel scoped to this screen
    return ChangeNotifierProvider(
      create: (context) => ChecklistTemplateAddViewModel(
        Provider.of<AddChecklistTemplateUseCase>(context, listen: false),
        Provider.of<GetSystemsUseCase>(context, listen: false),
        Provider.of<GetLocationsUseCase>(context, listen: false),
      ),
      child: Builder(
        builder: (context) {
          final addViewModel =
              Provider.of<ChecklistTemplateAddViewModel>(context);
          final listViewModel =
              Provider.of<ChecklistTemplatesListViewModel>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Add Checklist Template'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (addViewModel.isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (addViewModel.errorMessage != null)
                    Center(child: Text(addViewModel.errorMessage!))
                  else ...[
                    DropdownButtonFormField<int>(
                      value: addViewModel.selectedSystemId,
                      decoration: InputDecoration(labelText: 'Select System'),
                      onChanged: (int? newValue) {
                        addViewModel.setSelectedSystemId(newValue);
                      },
                      items: addViewModel.systems.map((system) {
                        return DropdownMenuItem<int>(
                          value: system.id,
                          child: Text(system.fullName),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: addViewModel.selectedLocationId,
                      decoration: InputDecoration(labelText: 'Select Location'),
                      onChanged: (int? newValue) {
                        addViewModel.setSelectedLocationId(newValue);
                      },
                      items: addViewModel.locations.map((location) {
                        return DropdownMenuItem<int>(
                          value: location.id,
                          child: Text(location.fullName),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: addViewModel.titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: addViewModel.descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        print(
                            'ChecklistTemplateAddScreen: Opening Add Item Dialog');
                        await _showAddItemDialog(context, addViewModel);
                      },
                      child: const Text('Add Item',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: addViewModel.checklistTemplateItems.length,
                        itemBuilder: (context, index) {
                          final item =
                              addViewModel.checklistTemplateItems[index];
                          return ListTile(
                            title: Text(item.title ?? 'No Title'),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle),
                              onPressed: () => addViewModel.removeItem(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                print(
                    'ChecklistTemplateAddScreen: Submitting checklist template');
                if (addViewModel.selectedSystemId == null ||
                    addViewModel.selectedLocationId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please select a system and location')),
                  );
                  return;
                }

                final newTemplate = ChecklistTemplate(
                  id: 0,
                  systemId: addViewModel.selectedSystemId!,
                  locationId: addViewModel.selectedLocationId!,
                  title: addViewModel.titleController.text,
                  description: addViewModel.descriptionController.text,
                  items: addViewModel.checklistTemplateItems,
                );

                final success =
                    await addViewModel.addChecklistTemplate(newTemplate);

                if (success) {
                  listViewModel.fetchChecklistTemplates();
                  print(
                      'ChecklistTemplateAddScreen: Checklist template added successfully');
                  Navigator.pop(context);
                } else {
                  print(
                      'ChecklistTemplateAddScreen: Failed to add checklist template');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add template')),
                  );
                }
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.check_sharp),
              tooltip: 'Add Checklist Template',
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAddItemDialog(
      BuildContext context, ChecklistTemplateAddViewModel viewModel) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    print('_showAddItemDialog: Opening dialog');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Checklist Item Template'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final checklistTemplateItem = ChecklistTemplateItem(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  print(
                      '_showAddItemDialog: Adding checklist template item - ${checklistTemplateItem.title}');
                  viewModel.addItem(checklistTemplateItem);
                  print(
                      '_showAddItemDialog: Checklist template item added successfully');
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
            ),
          ],
        );
      },
    );
  }
}
