import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_template.dart';
import 'package:fwp/features/clm/data/models/checklist.dart'; // Import Checklist model
import 'package:fwp/features/clm/presentation/view_models/checklist_add_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_dates_list_view_model.dart';
import 'package:provider/provider.dart';

class ChecklistAddScreen extends StatefulWidget {
  @override
  _ChecklistAddScreenState createState() => _ChecklistAddScreenState();
}

class _ChecklistAddScreenState extends State<ChecklistAddScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<ChecklistAddViewModel>(context, listen: false);

    // Retrieve the checklist passed as an argument from the previous screen
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    print('ChecklistAddScreen initialized with checklist: $checklist');

    // Fetch the checklist templates based on the systemId and locationId from the checklist
    print(
        'Fetching checklist templates for systemId: ${checklist.systemId}, locationId: ${checklist.locationId}');
    viewModel.loadChecklistTemplates(
      systemId: checklist.systemId!,
      locationId: checklist.locationId!,
    );

    // Set the default date in the view model
    print('Setting initial date: $selectedDate');
    viewModel.setDate(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      final viewModel =
          Provider.of<ChecklistAddViewModel>(context, listen: false);
      print('Date selected: $selectedDate');
      viewModel.setDate(selectedDate);
    } else {
      print('Date selection was canceled or unchanged');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the checklist passed as an argument from the previous screen
    final Checklist checklist =
        ModalRoute.of(context)!.settings.arguments as Checklist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ChecklistAddViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display system and location information from the checklist
                Text(
                  'System ID: ${checklist.systemId}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Location ID: ${checklist.locationId}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Date field (defaults to today's date)
                Text(
                  'Date:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(height: 16),

                // Dropdown for checklist templates filtered by systemId and locationId
                Text(
                  'Checklist Template:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                DropdownButton<ChecklistTemplate>(
                  hint: const Text('Select a template'),
                  value: viewModel.selectedTemplate,
                  items: viewModel.templates
                      .map((template) => DropdownMenuItem<ChecklistTemplate>(
                            value: template,
                            child: Text(template.title ?? 'No Title'),
                          ))
                      .toList(),
                  onChanged: (template) {
                    print('Template selected: $template');
                    viewModel.setSelectedTemplate(template);
                  },
                ),
                const SizedBox(height: 16),

                // Save button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).primaryColor, // Use theme color
                  ),
                  onPressed: () async {
                    print('Save checklist button pressed');
                    // Handle saving of the checklist using the selected date and template
                    viewModel.systemId = checklist.systemId;
                    viewModel.locationId = checklist.locationId;
                    final success = await viewModel.saveChecklist();
                    if (success) {
                      print('Checklist added successfully');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Checklist added successfully!')),
                      );
                      final checklistDatesListViewModel =
                          Provider.of<ChecklistDatesListViewModel>(context,
                              listen: false);
                      checklistDatesListViewModel.fetchChecklistDates(
                          checklist.systemId!, checklist.locationId!);
                      Navigator.pop(
                          context, true); // Pop the screen after saving
                    } else {
                      print('Failed to add checklist');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add checklist.')),
                      );
                    }
                  },
                  child: const Text(
                    'Save Checklist',
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
