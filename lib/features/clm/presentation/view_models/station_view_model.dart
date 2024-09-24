// import 'package:flutter/foundation.dart';
// import 'package:fwp/features/clm/data/models/station.dart';
// import 'package:fwp/features/clm/domain/use_cases/get_stations_use_case.dart';

// class StationViewModel extends ChangeNotifier {
//   final GetStationsUseCase getStationsUseCase;

//   List<Station> stations = [];
//   String? errorMessage;
//   bool isLoading = false;

//   StationViewModel(this.getStationsUseCase);

//   Future<void> fetchStations() async {
//     isLoading = true;
//     notifyListeners();
//     try {
//       stations = await getStationsUseCase.execute();
//       errorMessage = null;
//     } catch (e) {
//       errorMessage = e.toString();
//       stations = [];
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
