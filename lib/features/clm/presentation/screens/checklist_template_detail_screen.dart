import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist_template_item.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_detail_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:provider/provider.dart';

class ChecklistTemplateDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the viewModel to retrieve the selectedChecklistTemplate
    final viewModel = Provider.of<ChecklistTemplateDetailViewModel>(context);
    final template = viewModel.selectedChecklistTemplate;

    return Scaffold(
      appBar: AppBar(
        title: Text(template?.title ?? 'Template Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                template?.title ?? 'No Title',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Text(
                template?.description ?? 'No Description',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              _buildInfoRow('System ID:',
                  template?.systemId?.toString() ?? 'No System ID'),
              _buildInfoRow('Location ID:',
                  template?.locationId?.toString() ?? 'No Location ID'),
              SizedBox(height: 16),
              Text(
                'Checklist Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 8),
              Divider(),
              SizedBox(height: 8),
              // Display the checklist items with name and description
              ListView.builder(
                itemCount: template?.items.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevent scrolling
                itemBuilder: (context, index) {
                  final item = template?.items[index];
                  return _buildChecklistItem(item);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (template != null) {
            // Call the delete function from the viewModel
            await viewModel.deleteChecklistTemplateById(template.id);
            final listViewModel =
                Provider.of<ChecklistTemplatesListViewModel>(context);
            listViewModel.reset();
            listViewModel.fetchChecklistTemplates();
            // After deletion, navigate back
            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        tooltip: 'Delete Template',
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(ChecklistTemplateItem? item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(item?.title ?? 'No Name',
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(item?.description ?? 'No Description'),
        contentPadding: EdgeInsets.all(12.0),
      ),
    );
  }
}
