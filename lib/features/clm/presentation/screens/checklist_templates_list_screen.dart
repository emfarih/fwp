import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_template_detail_view_model.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_templates_list_view_model.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';

class ChecklistTemplatesListScreen extends StatefulWidget {
  @override
  _ChecklistTemplatesListScreenState createState() =>
      _ChecklistTemplatesListScreenState();
}

class _ChecklistTemplatesListScreenState
    extends State<ChecklistTemplatesListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add a listener to the scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreTemplates();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMoreTemplates() {
    final viewModel =
        Provider.of<ChecklistTemplatesListViewModel>(context, listen: false);
    if (!viewModel.isLoading && !viewModel.isLastPage) {
      print('Loading more checklist templates...');
      viewModel
          .fetchMoreChecklistTemplates(); // Implement this method in your ViewModel
    }
  }

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
          if (viewModel.isLoading && viewModel.checklistTemplates.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else {
            final templates = viewModel.checklistTemplates;
            return ListView.builder(
              controller: _scrollController, // Set the scroll controller
              itemCount: templates.length +
                  (viewModel.isLoading
                      ? 1
                      : 0), // Show loading indicator if loading more
              itemBuilder: (context, index) {
                if (index == templates.length) {
                  // Show a loading indicator at the bottom
                  return const Center(child: CircularProgressIndicator());
                }

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
