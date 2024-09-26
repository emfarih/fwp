import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/view_models/checklist_dates_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/routes.dart';

class ChecklistDatesListScreen extends StatefulWidget {
  const ChecklistDatesListScreen({super.key});

  @override
  _ChecklistDatesListScreenState createState() =>
      _ChecklistDatesListScreenState();
}

class _ChecklistDatesListScreenState extends State<ChecklistDatesListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add listener to detect when the user scrolls to the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('Scrolled to bottom, loading more dates...');
        _loadMoreDates();
      }
    });

    // Fetch initial checklist dates when screen initializes
    final checklist = ModalRoute.of(context)!.settings.arguments as Checklist;
    print('ChecklistDatesListScreen initialized with checklist: $checklist');

    final viewModel =
        Provider.of<ChecklistDatesListViewModel>(context, listen: false);
    if (viewModel.checklistDates.isEmpty && !viewModel.isLoading) {
      print(
          'Fetching initial checklist dates for systemId: ${checklist.systemId}, locationId: ${checklist.locationId}');
      viewModel.fetchChecklistDates(checklist.systemId!, checklist.locationId!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    print('ChecklistDatesListScreen disposed');
    super.dispose();
  }

  void _loadMoreDates() {
    final viewModel =
        Provider.of<ChecklistDatesListViewModel>(context, listen: false);
    final checklist = ModalRoute.of(context)!.settings.arguments as Checklist;

    // Only fetch more if not already loading and there are more dates to load
    if (!viewModel.isLoading && !viewModel.isLastPage) {
      print(
          'Loading more dates for systemId: ${checklist.systemId}, locationId: ${checklist.locationId}');
      viewModel.fetchMoreChecklistDates(
          checklist.systemId!, checklist.locationId!);
    } else {
      print('No more dates to load or already loading...');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistDatesListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Dates')),
      body: Consumer<ChecklistDatesListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.checklistDates.isEmpty) {
            print('Initial loading state: Showing progress indicator');
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            print('Error encountered: ${viewModel.errorMessage}');
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.checklistDates.isEmpty) {
            print('No checklist dates available.');
            return const Center(child: Text('No checklist dates available.'));
          }

          print(
              'Rendering checklist dates, total: ${viewModel.checklistDates.length}');
          return ListView.builder(
            controller: _scrollController, // Attach the scroll controller
            itemCount: viewModel.checklistDates.length +
                (viewModel.isLoading
                    ? 1
                    : 0), // Show loading indicator at the bottom
            itemBuilder: (context, index) {
              if (index == viewModel.checklistDates.length) {
                print(
                    'Reached end of list, showing progress indicator for more dates');
                return const Center(child: CircularProgressIndicator());
              }

              final checklistDate = viewModel.checklistDates[index];
              print('Rendering checklist date: $checklistDate');

              return CLMListTile(
                title: checklistDate,
                onTap: () {
                  // Handle date selection logic
                  print(
                      'ChecklistDatesListScreen: Date selected: $checklistDate');
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final checklist =
              ModalRoute.of(context)!.settings.arguments as Checklist;
          print(
              'Navigating to add new checklist for systemId: ${checklist.systemId}, locationId: ${checklist.locationId}');
          Navigator.pushNamed(
            context,
            AppRoutes.checklistAdd,
            arguments: checklist, // Pass checklist as arguments
          ).then((_) {
            print('Returning from add checklist screen, refreshing dates');
            viewModel.fetchChecklistDates(
                checklist.systemId!, checklist.locationId!);
          });
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Checklist',
      ),
    );
  }
}
