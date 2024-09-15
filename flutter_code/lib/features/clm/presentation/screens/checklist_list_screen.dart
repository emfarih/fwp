import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/widgets/checklist_tile.dart';
import 'package:provider/provider.dart';
import '../view_models/checklist_view_model.dart';

class ChecklistListScreen extends StatelessWidget {
  const ChecklistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChecklistViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checklists')),
      body: FutureBuilder<void>(
        future: viewModel.fetchChecklists(),
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }
          return ListView.builder(
            itemCount: viewModel.checklists.length,
            itemBuilder: (context, index) {
              final checklist = viewModel.checklists[index];
              return ChecklistTile(checklist: checklist);
            },
          );
        },
      ),
    );
  }
}
