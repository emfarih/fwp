import 'package:flutter/material.dart';
import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:fwp/features/clm/presentation/view_models/station_view_model.dart';

class StationListScreen extends StatelessWidget {
  const StationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StationViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Stations')),
      body: FutureBuilder<void>(
        future: viewModel.fetchStations(),
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          return ListView.builder(
            itemCount: viewModel.stations.length,
            itemBuilder: (context, index) {
              final station = viewModel.stations[index];
              return CLMListTile(
                title: station.fullName,
                subtitle: station.shortName,
                onTap: () {
                  // Handle station tap, e.g., navigate to checklists
                },
              );
            },
          );
        },
      ),
    );
  }
}
