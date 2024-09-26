import 'package:flutter/material.dart';
import 'package:fwp/features/clm/domain/use_cases/get_checklist_dates_use_case.dart';

class ChecklistDatesListViewModel extends ChangeNotifier {
  final GetChecklistDatesUseCase _getChecklistDatesUseCase;

  List<String> checklistDates = [];
  bool isLoading = false;
  bool isLastPage = false; // Track if last page of data has been reached
  String? errorMessage;

  static const int _limit = 20; // Number of items per page
  int _offset = 0; // Offset for pagination

  ChecklistDatesListViewModel(this._getChecklistDatesUseCase);

  // Fetch initial checklist dates
  Future<void> fetchChecklistDates(int systemId, int locationId) async {
    _resetPagination(); // Reset pagination data
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final dates = await _getChecklistDatesUseCase.call(
        systemId,
        locationId,
        limit: _limit,
        offset: _offset,
      );

      checklistDates = dates;
      _offset += dates.length; // Update offset for next batch

      if (dates.length < _limit) {
        isLastPage = true; // If fetched less than the limit, it’s the last page
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch more checklist dates (pagination)
  Future<void> fetchMoreChecklistDates(int systemId, int locationId) async {
    if (isLoading || isLastPage)
      return; // Prevent fetching if already loading or at last page

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final dates = await _getChecklistDatesUseCase.call(
        systemId,
        locationId,
        limit: _limit,
        offset: _offset,
      );

      checklistDates.addAll(dates); // Append new dates to the existing list
      _offset += dates.length; // Update offset for next batch

      if (dates.length < _limit) {
        isLastPage = true; // Mark as last page if less than limit
      }
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Reset pagination state when reloading data
  void _resetPagination() {
    checklistDates.clear();
    _offset = 0;
    isLastPage = false;
  }
}
