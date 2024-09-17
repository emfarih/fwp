import 'package:flutter/material.dart';
import '../view_models/checklist_view_model.dart';

class ChecklistDetailScreen extends StatelessWidget {
  final ChecklistViewModel viewModel;
  final int checklistId;

  ChecklistDetailScreen(
      {super.key, required this.viewModel, required this.checklistId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checklist Details')),
      body: FutureBuilder<void>(
        future: viewModel.fetchChecklistById(checklistId),
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }
          final checklist = viewModel.selectedChecklist;
          if (checklist == null) {
            return Center(child: Text('Checklist not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${checklist.location}'),
                Text('Inspection Date: ${checklist.inspectionDate?.toLocal()}'),
                Text('Inspection Type: ${checklist.inspectionType}'),
                // Add more details and lists for checklist items and photos
              ],
            ),
          );
        },
      ),
    );
  }
}
