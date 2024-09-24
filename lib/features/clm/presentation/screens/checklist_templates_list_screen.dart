import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_detail_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';

class ChecklistTemplatesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistTemplatesListViewModel>(context);

    // Fetch checklist templates only if not already loaded
    if (viewModel.checklistTemplates.isEmpty && !viewModel.isLoading) {
      viewModel.fetchChecklistTemplates();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist Templates'),
      ),
      body: Consumer<ChecklistTemplatesListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
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
                    print('Tapped on checklist template: ${template.title}');
                    final checklistTemplateDetailViewModel =
                        Provider.of<ChecklistTemplateDetailViewModel>(context,
                            listen: false);
                    checklistTemplateDetailViewModel
                        .setSelectedChecklistTemplate(
                            template); // Set selectedChecklist here

                    Navigator.pushNamed(
                        context,
                        AppRoutes
                            .checklistTemplateDetail // Replace with your detail route
                        );
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
          Navigator.pushNamed(context, AppRoutes.checklistTemplateAdd);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
