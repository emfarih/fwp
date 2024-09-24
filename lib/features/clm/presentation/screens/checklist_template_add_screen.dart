import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_template_item.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_add_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';

class ChecklistTemplateAddScreen extends StatefulWidget {
  @override
  _ChecklistTemplateAddScreenState createState() =>
      _ChecklistTemplateAddScreenState();
}

class _ChecklistTemplateAddScreenState
    extends State<ChecklistTemplateAddScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<ChecklistTemplateItem> _checklistTemplateItems = [];

  int? selectedSystemId;
  int? selectedLocationId;

  @override
  void initState() {
    super.initState();
    // Fetch systems and locations
    final viewModel =
        Provider.of<ChecklistTemplateAddViewModel>(context, listen: false);
    viewModel.fetchSystems();
    viewModel.fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistTemplateAddViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Checklist Template'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (viewModel.isLoading)
              Center(child: CircularProgressIndicator())
            else if (viewModel.errorMessage != null)
              Center(child: Text(viewModel.errorMessage!))
            else ...[
              DropdownButtonFormField<int>(
                value: selectedSystemId,
                decoration: InputDecoration(labelText: 'Select System'),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedSystemId = newValue;
                  });
                },
                items: viewModel.systems.map((system) {
                  return DropdownMenuItem<int>(
                    value: system.id,
                    child: Text(system.fullName),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16), // Added spacing
              DropdownButtonFormField<int>(
                value: selectedLocationId,
                decoration: InputDecoration(labelText: 'Select Location'),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedLocationId = newValue;
                  });
                },
                items: viewModel.locations.map((location) {
                  return DropdownMenuItem<int>(
                    value: location.id,
                    child: Text(location.fullName),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16), // Added spacing
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8), // Added spacing
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 8), // Added spacing
              ElevatedButton(
                onPressed: _showAddItemDialog,
                child: const Text(
                  'Add Item',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20), // Added spacing
              Expanded(
                child: ListView.builder(
                  itemCount: _checklistTemplateItems.length,
                  itemBuilder: (context, index) {
                    final item = _checklistTemplateItems[index];
                    return ListTile(
                      title: Text(item.title ?? 'No Title'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            _checklistTemplateItems.removeAt(index);
                          });
                        },
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
          // Check for selection and input values
          if (selectedSystemId == null || selectedLocationId == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please select a system and location')),
            );
            return;
          }

          // Handle adding the checklist template
          final newTemplate = ChecklistTemplate(
            id: 0,
            systemId: selectedSystemId!,
            locationId: selectedLocationId!,
            title: _titleController.text,
            description: _descriptionController.text,
          );

          final success = await viewModel.addChecklistTemplate(newTemplate);

          if (success) {
// Notify the list ViewModel to refresh
            final listViewModel = Provider.of<ChecklistTemplatesListViewModel>(
                context,
                listen: false);
            listViewModel.fetchChecklistTemplates();

            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add template')),
            );
          }
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.check_sharp),
        tooltip: 'Add Checklist Template',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> _showAddItemDialog() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

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
              const SizedBox(height: 8), // Added spacing
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
                  setState(() {
                    _checklistTemplateItems.add(checklistTemplateItem);
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Add Item'),
            ),
            TextButton(
              onPressed: () {
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
