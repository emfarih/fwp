import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_detail_view_model.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${template?.title ?? 'No Title'}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Description: ${template?.description ?? 'No Description'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'System ID: ${template?.systemId ?? 'No System ID'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Location ID: ${template?.locationId ?? 'No Location ID'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Display the checklist items with name and description
            Expanded(
              child: ListView.builder(
                itemCount: template?.items.length,
                itemBuilder: (context, index) {
                  final item = template?.items[index];
                  return ListTile(
                    title: Text(item?.title ??
                        'No Name'), // Assuming item has a 'name' field
                    subtitle: Text(item?.description ?? 'No Description'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
