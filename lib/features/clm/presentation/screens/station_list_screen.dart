// import 'package:flutter/material.dart';
// import 'package:fwp/features/clm/data/models/checklist.dart';
// import 'package:fwp/features/clm/data/models/location_type.dart';
// import 'package:fwp/features/clm/presentation/widgets/clm_list_tile.dart';
// import 'package:fwp/routes.dart';
// import 'package:provider/provider.dart';
// import 'package:fwp/features/clm/presentation/view_models/station_view_model.dart';

// class StationsListScreen extends StatelessWidget {
//   const StationsListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<StationViewModel>(context);

//     // Retrieve the checklist from modal route arguments
//     final Checklist checklist =
//         ModalRoute.of(context)!.settings.arguments as Checklist;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Stations')),
//       body: FutureBuilder<void>(
//         future: viewModel.fetchStations(),
//         builder: (context, snapshot) {
//           if (viewModel.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (viewModel.errorMessage != null) {
//             return Center(child: Text(viewModel.errorMessage!));
//           }

//           return ListView.builder(
//             itemCount: viewModel.stations.length,
//             itemBuilder: (context, index) {
//               final station = viewModel.stations[index];
//               return CLMListTile(
//                 title: station.fullName,
//                 subtitle: station.shortName,
//                 onTap: () {
//                   // Update checklist's locationTypeId
//                   checklist.locationTypeId = LocationTypeEnum
//                       .station.id; // Assuming Checklist has a setter
//                   checklist.stationId =
//                       station.id; // Assuming Checklist has a setter

//                   // Navigate to checklists list screen
//                   Navigator.pushNamed(
//                     context,
//                     AppRoutes.checklistsList,
//                     arguments: checklist, // Pass the updated checklist
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
