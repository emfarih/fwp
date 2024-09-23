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
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    final viewModel =
        Provider.of<ChecklistDetailViewModel>(context, listen: false);
    inspectorController =
        TextEditingController(text: viewModel.selectedChecklist?.inspectorName);
    dateController = TextEditingController(
      text: viewModel.selectedChecklist?.date != null
          ? viewModel.selectedChecklist?.date
              ?.toLocal()
              .toString()
              .split(' ')[0] // Show the date in a yyyy-mm-dd format
          : '',
    );
    print(
        'ChecklistDetailScreen: Initialized with inspector name: ${inspectorController.text} and date: ${dateController.text}');
  }

  @override
  void dispose() {
    inspectorController.dispose();
    dateController.dispose();
    super.dispose();
    print('ChecklistDetailScreen: Disposed controllers.');
  }

  void _selectDate(BuildContext context) async {
    final viewModel =
        Provider.of<ChecklistDetailViewModel>(context, listen: false);
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: viewModel.selectedChecklist?.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != viewModel.selectedChecklist?.date) {
      setState(() {
        dateController.text = pickedDate.toLocal().toString().split(' ')[0];
      });
      print('ChecklistDetailScreen: Date selected: ${dateController.text}');
      // Update the selected checklist in the view model
      viewModel.selectedChecklist?.date = pickedDate;
    }
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
                'ChecklistDetailScreen: AppBar title set to: ${selectedChecklist?.description ?? 'Checklist Details'}');
            return Text(selectedChecklist?.description ?? 'Checklist Details');
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
                TextField(
                  controller: inspectorController,
                  decoration:
                      const InputDecoration(labelText: 'Inspector Name'),
                  onChanged: (value) {
                    print(
                        'ChecklistDetailScreen: Inspector name changed to: $value');
                    viewModel.selectedChecklist?.inspectorName = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  onChanged: (value) {
                    print('ChecklistDetailScreen: Date changed to: $value');
                  },
                ),
                const SizedBox(height: 16),
                Text('Checklist Items:',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedChecklist.checklistItems?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = selectedChecklist.checklistItems?[index];
                      if (item == null) return const SizedBox();
                      return ChecklistItemTile(
                          checklistItem: item, viewModel: viewModel);
                    },
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

          // Optionally, navigate back or show a success message
        },
        tooltip: 'Submit Changes',
        child: const Icon(Icons.check),
      ),
    );
  }
}
