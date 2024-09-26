import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/checklists_list_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:provider/provider.dart';

class ChecklistListScreen extends StatefulWidget {
  const ChecklistListScreen({super.key});

  @override
  _ChecklistListScreenState createState() => _ChecklistListScreenState();
}

class _ChecklistListScreenState extends State<ChecklistListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Fetch initial checklists
    final checklist = ModalRoute.of(context)!.settings.arguments as Checklist;
    print('ChecklistListScreen initialized with checklist: $checklist');

    final viewModel =
        Provider.of<ChecklistListViewModel>(context, listen: false);
    if (viewModel.checklists.isEmpty && !viewModel.isLoading) {
      print(
          'Fetching initial checklists for systemId: ${checklist.systemId}, locationId: ${checklist.locationId}, date: ${checklist.date}');
      viewModel.fetchChecklists(
          checklist.systemId!, checklist.locationId!, checklist.date!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklists'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChecklistListViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading && viewModel.checklists.isEmpty) {
                  print('Loading initial checklists...');
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.errorMessage != null) {
                  print('Error: ${viewModel.errorMessage}');
                  return Center(child: Text(viewModel.errorMessage!));
                }

                if (viewModel.checklists.isEmpty) {
                  print('No checklists available.');
                  return const Center(child: Text('No checklists available.'));
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: viewModel.checklists.length,
                  itemBuilder: (context, index) {
                    final checklist = viewModel.checklists[index];
                    print('Rendering checklist: $checklist');
                    return CLMListTile(
                      title: checklist.title ?? 'No Title',
                      onTap: () {
                        print('Checklist selected: $checklist');
                        // Handle checklist selection
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
