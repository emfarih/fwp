// import 'package:flutter/foundation.dart';
// import 'package:fwp/features/clm/data/models/substation.dart';
// import 'package:fwp/features/clm/domain/use_cases/get_substations_use_case.dart';

// class SubstationViewModel extends ChangeNotifier {
//   final GetSubstationsUseCase getSubstationsUseCase;

//   SubstationViewModel(this.getSubstationsUseCase);

//   bool isLoading = false;
//   String? errorMessage;
//   List<Substation> substations = [];

//   Future<void> fetchSubstations() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       substations = await getSubstationsUseCase.execute();
//       errorMessage = null;
//     } catch (error) {
//       errorMessage = 'Failed to load substations';
//       print('SubstationViewModel: Error occurred: $error');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
