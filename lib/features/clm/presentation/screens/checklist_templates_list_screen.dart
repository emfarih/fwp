import 'package:flutter/material.dart';
import 'package:fwp/features/aam/presentation/view_models/auth_view_model.dart';
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
    final viewModel = Provider.of<ChecklistTemplatesListViewModel>(context);

    // Fetch checklist templates only if not already loaded
    if (viewModel.checklistTemplates.isEmpty && !viewModel.isLoading) {
      viewModel.fetchChecklistTemplates();
    }

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
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checklist Templates'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await authViewModel.logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: Consumer<ChecklistTemplatesListViewModel>(
        builder: (context, viewModel, child) {
          print(
              'ChecklistTemplatesListScreenInsideConsumer: isLoading = ${viewModel.isLoading}, isLastPage = ${viewModel.isLastPage}, templates count = ${viewModel.checklistTemplates.length}');
          if (viewModel.isLoading && viewModel.checklistTemplates.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          } else if (viewModel.checklistTemplates.isEmpty &&
              !viewModel.isLoading) {
            return Center(child: Text('No checklist templates available.'));
          } else {
            final templates = viewModel.checklistTemplates;
            return ListView.builder(
              controller: _scrollController,
              itemCount: templates.length + (viewModel.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == templates.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final template = templates[index];
                return CLMListTile(
                  title: template.title ?? 'No Title',
                  subtitle: template.description ?? 'No Description',
                  onTap: () {
                    final checklistTemplateDetailViewModel =
                        Provider.of<ChecklistTemplateDetailViewModel>(context,
                            listen: false);
                    checklistTemplateDetailViewModel
                        .setSelectedChecklistTemplate(template);

                    Navigator.pushNamed(
                        context, AppRoutes.checklistTemplateDetail);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.checklistTemplateAdd);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
