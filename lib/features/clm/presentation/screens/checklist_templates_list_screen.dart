import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart'; // Import your CLMListTile

class ChecklistTemplatesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistTemplatesViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist Templates'),
      ),
      body: FutureBuilder(
        future: viewModel.fetchChecklistTemplates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final templates = viewModel.checklistTemplates;
            return ListView.builder(
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                return CLMListTile(
                  title: template.title ?? 'No Title',
                  subtitle: template.description ?? 'No Description',
                  onTap: () {
                    // Handle tap on the checklist template
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding a new checklist template
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
