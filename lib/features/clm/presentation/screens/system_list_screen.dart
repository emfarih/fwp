import 'package:flutter/material.dart';
import 'package:fwp/features/clm/data/models/checklist.dart';
import 'package:fwp/features/clm/presentation/view_models/system_view_model.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:fwp/routes.dart';
import 'package:provider/provider.dart';

class SystemsListScreen extends StatelessWidget {
  const SystemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final systemViewModel = Provider.of<SystemViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Systems'),
      ),
      body: FutureBuilder<void>(
        future: systemViewModel.fetchSystems(),
        builder: (context, snapshot) {
          if (systemViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (systemViewModel.errorMessage != null) {
            return Center(child: Text(systemViewModel.errorMessage!));
          }

          return ListView.builder(
            itemCount: systemViewModel.systems.length,
            itemBuilder: (context, index) {
              final system = systemViewModel.systems[index];
              return CLMListTile(
                title: system.fullName,
                subtitle: system.shortName,
                onTap: () {
                  // Navigate globally to the locationsList screen
                  Navigator.pushNamed(
                    context,
                    AppRoutes.locationsList,
                    arguments: Checklist(systemId: system.id),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
